//
//  Created by 조유진 on 2/12/25.
//
import Combine
import Foundation


enum SomeError: Error {
    case deallocated
}

final class TypingViewModel: ViewModelType{
    private var cancellables = Set<AnyCancellable>()
    private let timerUseCase: TimerUseCase
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
        let inputAttributedString: AnyPublisher<NSAttributedString, Never>
    }

    init(timerUseCase: TimerUseCase, fetchPilsaInfoUseCase: FetchPilsaInfoUseCase) {
        self.timerUseCase = timerUseCase
        self.fetchPilsaInfoUseCase = fetchPilsaInfoUseCase
    }
    
    func transform(input: Input) -> Output {
        let pilsaInfoSubject = PassthroughSubject<PilsaInfo, Never>()
        let currentTextSubject = CurrentValueSubject<String, Never>("")
        
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
        
        let typingStarted = input.textViewDidChanged
            .filter { !$0.isEmpty }
            .map { _ in return () }
            .prefix(1)
            .eraseToAnyPublisher()
        
        input.textViewDidChanged
            .sink { inputText in
                currentTextSubject.send(inputText)
            }
            .store(in: &cancellables)
        
        typingStarted.sink { _ in
            let currentText = String(currentTextSubject.value.removeFirst())
            currentTextSubject.send(currentText)
        }
        .store(in: &cancellables)
             
        let timerOutput = typingStarted
            .combineLatest(pilsaInfoSubject)
            .flatMap { [weak self] (_, pilsaInfo) ->  AnyPublisher<(
                                                        elapsedTime: AnyPublisher<Int, Never>,
                                                        wpmValue: AnyPublisher<Int, Never>,
                                                        inputAttributedString: AnyPublisher<NSAttributedString, Never>,
                                                        finished: AnyPublisher<PilsaTypingResult, Never>), Never> in
                guard let self = self else { return Empty().eraseToAnyPublisher() }
                let output = timerUseCase.startTypingTimer(
                    pilsaInfo: pilsaInfo,
                    inputText: currentTextSubject,
                    every: 1.0,
                    endSeconds: 60
                )
                return Just(output).eraseToAnyPublisher()
            }
            .share()
        
       let elapsedTime = timerOutput
            .flatMap { $0.elapsedTime }
            .eraseToAnyPublisher()
        
       let wpmValue = timerOutput
            .flatMap { $0.wpmValue }
            .eraseToAnyPublisher()
        
       let inputAttributedString = timerOutput
            .flatMap { $0.inputAttributedString }
            .eraseToAnyPublisher()
        
        let playTimeFinished = timerOutput
            .flatMap { $0.finished }
            .eraseToAnyPublisher()
        
        
        return Output(
            pilsaInfo: pilsaInfoSubject.eraseToAnyPublisher(),
            typingStarted: typingStarted,
            elapsedTime: elapsedTime,
            wpmValue: wpmValue,
            playTimeFinished: playTimeFinished,
            inputAttributedString: inputAttributedString
        )
    }
}
