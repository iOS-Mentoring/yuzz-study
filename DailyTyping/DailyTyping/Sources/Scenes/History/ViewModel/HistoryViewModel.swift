//
//  HistoryViewModel.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//

import Combine

final class HistoryViewModel: ViewModelType {
    private var cancellables = Set<AnyCancellable>()
    
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        
        input.viewDidLoad
            .sink { _ in
                
            }
            .store(in: &cancellables)
        
        
        return Output()
    }
}
