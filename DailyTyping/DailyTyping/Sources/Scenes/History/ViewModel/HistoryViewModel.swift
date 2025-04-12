//
//  HistoryViewModel.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//

import Combine

final class HistoryViewModel: ViewModelType {
    private var cancellables = Set<AnyCancellable>()
    private let calendarUseCase: CalendarUseCase
    
    init(calendarUseCase: CalendarUseCase) {
        self.calendarUseCase = calendarUseCase
    }
    
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let calendarItemPublisher: AnyPublisher<[CalendarPilsaItem], Never>
    }
    
    func transform(input: Input) -> Output {
        let calendarItemsSubject = PassthroughSubject<[CalendarPilsaItem], Never>()
        
        input.viewDidLoad
            .map {
                [weak self] _ in
                guard let self else { return [] } 
                let items: [CalendarPilsaItem] = calendarUseCase.getCurrentWeekDates().map { CalendarPilsaItem(day: $0, isCompleted: true) }
                print(items)
                return items
            }
            .sink { items in
            calendarItemsSubject.send(items)
        }
        .store(in: &cancellables)
        
        return Output(
            calendarItemPublisher: calendarItemsSubject.eraseToAnyPublisher()
        )
    }
}
