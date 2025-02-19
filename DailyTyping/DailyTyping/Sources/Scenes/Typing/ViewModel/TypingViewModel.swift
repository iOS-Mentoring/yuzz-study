//
//  Created by 조유진 on 2/12/25.
//
import Combine
import Foundation
final class TypingViewModel: ViewModelType{
    private  var cancellables = Set<AnyCancellable>()
    private let timeProvider: TimeProvider
    
    struct Input {
        let historyButtonTapped: AnyPublisher<Void, Never>
        let linkButtonTapped: AnyPublisher<Void, Never>
        let textViewDidChanged: AnyPublisher<String, Never>
    }
    
    struct Output {
        let historyButtonTapped: AnyPublisher<Void, Never>
        let linkButtonTapped: AnyPublisher<Void, Never>
        let typingStarted: AnyPublisher<Void, Never>
        let elapsedTime: AnyPublisher<Int, Never>
        let wpmValue: AnyPublisher<Int, Never>
        let playTimeFinished: AnyPublisher<PilsaTypingResult, Never>
        let typingFinished: AnyPublisher<PilsaTypingResult, Never>
        let validateInputText: AnyPublisher<NSAttributedString, Never>
        
        let keyboardHeight: AnyPublisher<CGFloat, Never>
    }

    init(timeProvider: TimeProvider) {
        print(#function)
        self.timeProvider = timeProvider
    }
    
    func transform(input: Input) -> Output {
        let elapsedTimePublisher = PassthroughSubject<Int, Never>()
        let textEverySecond = PassthroughSubject<(String, Int), Never>()
        let wpmValue = CurrentValueSubject<Int, Never>(0)
        let currentText = CurrentValueSubject<String, Never>("")
        let playTimeFinished = PassthroughSubject<PilsaTypingResult, Never>()
        let typingFinished = PassthroughSubject<PilsaTypingResult, Never>()
        let validateInputText = PassthroughSubject<NSAttributedString, Never>()
        
        let keyboardHeightSubject = CurrentValueSubject<CGFloat, Never>(0)

        let historyButtonTapped = input.historyButtonTapped
            .eraseToAnyPublisher()
        
        let linkButtonTapped = input.linkButtonTapped
            .eraseToAnyPublisher()
        
        // 처음으로 빈 문자열이 아닌 값이 입력되었을 때 이벤트 방출
        let typingStart = input.textViewDidChanged
            .filter { !$0.isEmpty }
            .map { _ in return () }
            .prefix(1)  // 처음 방출 이후 스트림 완료 -> 더 이상 구독 X
            .eraseToAnyPublisher()
        
        
        input.textViewDidChanged.sink { text in // 최근 텍스트 저장
            currentText.send(text)
            if text.isMatchHangulCharacter() {
                typingFinished.send((PilsaTypingResult(pilsaPerformance: .init(wpm: wpmValue.value, acc: text.calculateAcc(), date: Date()))))
                textEverySecond.send(completion: .finished)
                wpmValue.send(completion: .finished)
                elapsedTimePublisher.send(completion: .finished)
            }
            validateInputText.send(text.validateCharacter())
        }
        .store(in: &cancellables)
        
        textEverySecond.sink { (text, second) in
            let count = text.getMatchHangulCharacterCount()
            let wpm = second.getWPM(characterCount: count)
            wpmValue.send(wpm)
        }
        .store(in: &cancellables)
    
        
        typingStart.sink { [weak self] _ in  // 타이핑 시작됐을 때
            guard let self else { return }
            let timerPublisher = timeProvider.timerPublisher(every: 1.0, endSeconds: 60)    // 타이머 시작
            
            timerPublisher.sink(receiveCompletion: { completion in
                switch completion {
                case .finished: // 타이머(60초) 끝났을 때
                    playTimeFinished.send(PilsaTypingResult(
                        pilsaPerformance: .init(
                            wpm: wpmValue.value,
                            acc: currentText.value.calculateAcc(),
                            date: Date()
                        )
                    ))
                    textEverySecond.send(completion: .finished)
                    wpmValue.send(completion: .finished)
                    elapsedTimePublisher.send(completion: .finished)
                }
            }, receiveValue: { seconds in   // 타이머 진행 값
                elapsedTimePublisher.send(seconds)
                textEverySecond.send((currentText.value, seconds))
            })
            .store(in: &cancellables)
        }
        .store(in: &cancellables)
        
        
        // MARK: 키보드 높이 구독
        CombineKeyboard.shared.visibleHeight
            .sink { height in
                keyboardHeightSubject.send(height)
            }
            .store(in: &cancellables)
    
        
        return Output(
            historyButtonTapped: historyButtonTapped,
            linkButtonTapped: linkButtonTapped,
            typingStarted: typingStart,
            elapsedTime: elapsedTimePublisher.eraseToAnyPublisher(),
            wpmValue: wpmValue.eraseToAnyPublisher(),
            playTimeFinished: playTimeFinished.eraseToAnyPublisher(),
            typingFinished: typingFinished.eraseToAnyPublisher(),
            validateInputText: validateInputText.eraseToAnyPublisher(),
            keyboardHeight: keyboardHeightSubject.eraseToAnyPublisher()
        )
    }
}
