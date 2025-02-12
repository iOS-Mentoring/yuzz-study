//
//  TypingViewModel.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//

import Combine

final class TypingViewModel: ViewModelType{
    private  var cancellables = Set<AnyCancellable>()
    
    struct Input {
        let historyButtonTapped: AnyPublisher<Void, Never>
        let linkButtonTapped: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let historyButtonTapped: AnyPublisher<Void, Never>
        let linkButtonTapped: AnyPublisher<Void, Never>
    }
    
    func transform(input: Input) -> Output {
        let historyButtonTapped = input.historyButtonTapped
            .eraseToAnyPublisher()
        
        let linkButtonTapped = input.linkButtonTapped
            .eraseToAnyPublisher()
        
        return Output(
            historyButtonTapped: historyButtonTapped,
            linkButtonTapped: linkButtonTapped
        )
    }
}
