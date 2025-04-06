//
//  Created by 조유진 on 2/12/25.
//
import Combine
import Foundation


enum SomeError: Error {
    case deallocated
}

final class TypingViewModel: ViewModelType{
    private  var cancellables = Set<AnyCancellable>()
    private let timeProvider: TimeProvider
    private let fetchPilsaInfoUseCase: FetchPilsaInfoUseCase
    
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let textViewDidChanged: AnyPublisher<String, Never>
    }
    
    struct Output {
        let pilsaInfo: AnyPublisher<PilsaInfo, Never>
        let typingStarted: AnyPublisher<Void, Never>
        let elapsedTime: AnyPublisher<Int, Never>
        let wpmValue: AnyPublisher<Int, Never>
        let playTimeFinished: AnyPublisher<PilsaTypingResult, Never>
        let typingFinished: AnyPublisher<PilsaTypingResult, Never>
        let validateInputText: AnyPublisher<NSAttributedString, Never>
    }

    init(timeProvider: TimeProvider, fetchPilsaInfoUseCase: FetchPilsaInfoUseCase) {
        print(#function)
        self.timeProvider = timeProvider
        self.fetchPilsaInfoUseCase = fetchPilsaInfoUseCase
    }
    
    func transform(input: Input) -> Output {
        let pilsaInfoSubject = PassthroughSubject<PilsaInfo, Never>()
        let elapsedTimePublisher = PassthroughSubject<Int, Never>()
        let textEverySecond = PassthroughSubject<(String, Int), Never>()
        let wpmValue = CurrentValueSubject<Int, Never>(0)
        let currentText = CurrentValueSubject<String, Never>("")
        let playTimeFinished = PassthroughSubject<PilsaTypingResult, Never>()
        let typingFinished = PassthroughSubject<PilsaTypingResult, Never>()
        let validateInputText = PassthroughSubject<NSAttributedString, Never>()
        
        input.viewDidLoad
             .flatMap { [weak self] _ -> AnyPublisher<PilsaInfo, Never> in
                 guard let self else {
                     return Empty<PilsaInfo, Never>().eraseToAnyPublisher()
                 }
                 return self.fetchPilsaInfoUseCase.execute().eraseToAnyPublisher()
             }
             .sink { pilsaInfo in
                 pilsaInfoSubject.send(pilsaInfo)
             }
             .store(in: &cancellables)
        
        // 처음으로 빈 문자열이 아닌 값이 입력되었을 때 이벤트 방출
        let typingStart = input.textViewDidChanged
            .filter { !$0.isEmpty }
            .map { _ in return () }
            .prefix(1)
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
        
        textEverySecond.sink { [weak self] (text, second) in
            guard let self else { return }
            let count = text.getMatchHangulCharacterCount()
            let wpm = getWPM(second: second, characterCount: count)
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
        
        
        return Output(
            pilsaInfo: pilsaInfoSubject.eraseToAnyPublisher(),
            typingStarted: typingStart,
            elapsedTime: elapsedTimePublisher.eraseToAnyPublisher(),
            wpmValue: wpmValue.eraseToAnyPublisher(),
            playTimeFinished: playTimeFinished.eraseToAnyPublisher(),
            typingFinished: typingFinished.eraseToAnyPublisher(),
            validateInputText: validateInputText.eraseToAnyPublisher()
        )
    }
    
    private func getWPM(second: Int, characterCount: Int) -> Int {
        let minutes = Double(second) / 60.0
        let wpm = minutes > 0 ? Double(characterCount) / minutes : 0
        return Int(wpm.rounded())
    }
}
