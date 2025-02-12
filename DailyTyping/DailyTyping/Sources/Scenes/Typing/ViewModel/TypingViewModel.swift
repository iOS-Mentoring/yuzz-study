//
//  TypingViewModel.swift
//  DailyTyping
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
    }
    
    init(timeProvider: TimeProvider) {
        print(#function)
        self.timeProvider = timeProvider
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
        
        typingStart.sink { [weak self] text in  // 타이핑 시작됐을 때
            guard let self else { return }
            let timerPublisher = timeProvider.timerPublisher(every: 1.0)    // 타이머 시작
            
            timerPublisher.sink(receiveCompletion: { completion in
                switch completion {
                case .finished: // 타이머(60초) 끝났을 때
                    print("60초 끝")
                }
            }, receiveValue: { seconds in   // 타이머 진행 값
                print("경과 \(seconds)초")
            })
            .store(in: &cancellables)
        }
        .store(in: &cancellables)
    
        
        return Output(
            historyButtonTapped: historyButtonTapped,
            linkButtonTapped: linkButtonTapped
        )
    }
}
