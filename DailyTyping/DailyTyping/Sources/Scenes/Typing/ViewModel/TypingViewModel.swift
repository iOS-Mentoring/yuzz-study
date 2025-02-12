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
        let textViewDidChanged: AnyPublisher<String, Never>
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
        
        // 처음으로 빈 문자열이 아닌 값이 입력되었을 때 이벤트 방출
        let typingStart = input.textViewDidChanged
            .filter { !$0.isEmpty }
            .prefix(1)  // 처음 방출 이후 스트림 완료 -> 더 이상 구독 X
            .eraseToAnyPublisher()
        
        typingStart.sink { text in
            print(text)
        }
        .store(in: &cancellables)
        
        return Output(
            historyButtonTapped: historyButtonTapped,
            linkButtonTapped: linkButtonTapped
        )
    }
}
