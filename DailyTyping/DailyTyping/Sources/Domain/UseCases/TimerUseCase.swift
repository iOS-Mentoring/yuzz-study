//
//  TimerUseCase.swift
//  DailyTyping
//
//  Created by 조유진 on 4/6/25.
//

import Foundation
import Combine

protocol TimerUseCase {
    func startTypingTimer(
        pilsaInfo: PilsaInfo,
        inputText: CurrentValueSubject<String, Never>,
        every seconds: TimeInterval,
        endSeconds: Int
    ) -> (
        elapsedTime: AnyPublisher<Int, Never>,
        wpmValue: AnyPublisher<Int, Never>,
        inputAttributedString: AnyPublisher<NSAttributedString, Never>,
        finished: AnyPublisher<PilsaTypingResult, Never>
    )
}

final class TimerUseCaseImpl: TimerUseCase {
    
    private let pilsaUseCase: PilsaUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(pilsaUseCase: PilsaUseCase) {
        self.pilsaUseCase = pilsaUseCase
    }
    
    // 내부에서 사용할 타이머 publisher 생성 함수
    private func timerPublisher(every seconds: TimeInterval, endSeconds: Int) -> AnyPublisher<Int, Never> {
        Timer.publish(every: seconds, on: .main, in: .common)
            .autoconnect()
            .scan(0) { seconds, _ in seconds + 1 }
            .prefix(endSeconds)
            .eraseToAnyPublisher()
    }
    
    func startTypingTimer(
        pilsaInfo: PilsaInfo,
        inputText: CurrentValueSubject<String, Never>,
        every seconds: TimeInterval,
        endSeconds: Int
    ) -> (
        elapsedTime: AnyPublisher<Int, Never>,
        wpmValue: AnyPublisher<Int, Never>,
        inputAttributedString: AnyPublisher<NSAttributedString, Never>,
        finished: AnyPublisher<PilsaTypingResult, Never>
    ) {
        
        let currentText = CurrentValueSubject<String, Never>("")
        
        let timerPub = timerPublisher(every: seconds, endSeconds: endSeconds)
            .share()
        
        inputText.sink { text in
            currentText.send(text)
        }
        .store(in: &cancellables)
        
        let elapsedTime = timerPub.eraseToAnyPublisher()
        
        let wpmValue = timerPub
            .combineLatest(currentText)
            .map { [weak self] second, text in
                guard let self else { return 0 }
                return pilsaUseCase.calculateWPM(pilsaMessage: pilsaInfo.message, second: second, text: text)
            }
            .eraseToAnyPublisher()
        
        let inputAttributedString = currentText
            .map { [weak self] text in
                guard let self else { return NSAttributedString() }
                return pilsaUseCase.validateCharacter(text: text, pilsaMessage: pilsaInfo.message)
            }
            .eraseToAnyPublisher()
        
        let earlyFinish = currentText
            .combineLatest(timerPub)
            .filter { [weak self] text, _ in
                guard let self else { return false }
                return pilsaUseCase.isMatchHangulCharacter(text: text, pilsaMessage: pilsaInfo.message)
            }
            .map { [weak self] text, second in
                guard let self = self else {
                    let performance = PilsaPerformance(wpm: 0, acc: 0, date: Date())
                    return PilsaTypingResult(pilsaInfo: pilsaInfo, pilsaPerformance: performance)
                }
                return self.pilsaUseCase.createPilsaResult(
                    pilsaInfo: pilsaInfo,
                    second: second,
                    text: text
                )
            }
            .prefix(1)
            .eraseToAnyPublisher()
        
        let normalFinish = timerPub
            .last()
            .combineLatest(currentText)
            .map { [weak self] lastSecond, text in
                guard let self else {
                    let performance = PilsaPerformance(
                        wpm: 0, acc: 0, date: Date()
                    )
                    return PilsaTypingResult(pilsaInfo: pilsaInfo, pilsaPerformance: performance)
                }
                
                return pilsaUseCase.createPilsaResult(pilsaInfo: pilsaInfo, second: lastSecond, text: text)
            }
            .eraseToAnyPublisher()
        
        let finished = earlyFinish
            .merge(with: normalFinish)
            .prefix(1)
            .eraseToAnyPublisher()
        
        return (elapsedTime, wpmValue, inputAttributedString, finished)
    }
}
