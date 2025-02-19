//
//  TypingCompletedViewModel.swift
//  DailyTyping
//
//  Created by 조유진 on 2/14/25.
//

import Combine

final class TypingCompletedViewModel: ViewModelType {
    private var cancellables = Set<AnyCancellable>()
    
    struct Input {
        let viewDidLoad: AnyPublisher<PilsaTypingResult, Never>
        let closeButtonTapped: AnyPublisher<Void, Never>
        let downloadImageButtonTapped: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let pilsaTypingResult: AnyPublisher<PilsaTypingResult, Never>
        let closeButtonTapped: AnyPublisher<Void, Never>
        let downloadImageButtonTapped: AnyPublisher<Void, Never>
    }
    
    func transform(input: Input) -> Output {
        
        let viewDidLoad = input.viewDidLoad
            .eraseToAnyPublisher()
        
        let closeButtonTapped = input.closeButtonTapped
            .eraseToAnyPublisher()
        
        let downloadImageButtonTapped = input.downloadImageButtonTapped
            .eraseToAnyPublisher()
        
        return Output(
            pilsaTypingResult: viewDidLoad,
            closeButtonTapped: closeButtonTapped,
            downloadImageButtonTapped: downloadImageButtonTapped
        )
    }
}
