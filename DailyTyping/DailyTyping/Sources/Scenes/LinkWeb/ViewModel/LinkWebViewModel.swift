//
//  LinkWebViewModel.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//

import Combine

final class LinkWebViewModel: ViewModelType {
    private var cancellables = Set<AnyCancellable>()
    
    struct Input {
        let viewDidLoadTrigger: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let viewDidLoad: AnyPublisher<Void, Never>
    }
    
    func transform(input: Input) -> Output {
        let viewDidLoad = input.viewDidLoadTrigger.eraseToAnyPublisher()
        return Output(viewDidLoad: viewDidLoad)
    }
}

