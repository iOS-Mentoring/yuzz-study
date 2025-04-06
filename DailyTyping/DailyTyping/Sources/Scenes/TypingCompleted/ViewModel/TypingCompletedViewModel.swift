//
//  TypingCompletedViewModel.swift
//  DailyTyping
//
//  Created by 조유진 on 2/14/25.
//

import Combine

final class TypingCompletedViewModel: ViewModelType {
    private var cancellables = Set<AnyCancellable>()
    
    private let pilsaTypingResult: PilsaTypingResult
    
    init(pilsaTypingResult: PilsaTypingResult) {
        self.pilsaTypingResult = pilsaTypingResult
    }
    
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let closeButtonTapped: AnyPublisher<Void, Never>
        let downloadImageButtonTapped: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let pilsaTypingResult: AnyPublisher<PilsaTypingResult, Never>
        let closeButtonTapped: AnyPublisher<Void, Never>
        let downloadImageButtonTapped: AnyPublisher<Void, Never>
    }
    
    func transform(input: Input) -> Output {
        let pilsaTypingResultSubject = PassthroughSubject<PilsaTypingResult, Never>()
        
        input.viewDidLoad
            .sink { [weak self] _ in
                guard let self else { return }
                pilsaTypingResultSubject.send(pilsaTypingResult)
            }
            .store(in: &cancellables)
        
        let closeButtonTapped = input.closeButtonTapped
            .eraseToAnyPublisher()
        
        let downloadImageButtonTapped = input.downloadImageButtonTapped
            .eraseToAnyPublisher()
        
        return Output(
            pilsaTypingResult: pilsaTypingResultSubject.eraseToAnyPublisher(),
            closeButtonTapped: closeButtonTapped,
            downloadImageButtonTapped: downloadImageButtonTapped
        )
    }
}
