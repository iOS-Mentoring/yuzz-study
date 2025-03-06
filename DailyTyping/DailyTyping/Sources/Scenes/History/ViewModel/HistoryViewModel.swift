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
        let configureDataSource: AnyPublisher<Void, Never>
        let calendarItemPublisher: AnyPublisher<[CalendarPilsaItem], Never>
    }
    
    func transform(input: Input) -> Output {
        let calendarItemsSubject = CurrentValueSubject<[CalendarPilsaItem], Never>([])
        
        input.viewDidLoad.sink { [weak self] in
            guard let self else { return }
            
            let calendarManager = CalendarManager()
            var items: [CalendarPilsaItem] = []
            for date in calendarManager.getCurrentWeekDates() {
                items.append(CalendarPilsaItem(day: date, isCompleted: true))
            }
            calendarItemsSubject.send(items)
        }
        .store(in: &cancellables)
        
        return Output(
            configureDataSource: input.viewDidLoad.eraseToAnyPublisher(),
            calendarItemPublisher: calendarItemsSubject.eraseToAnyPublisher()
        )
    }
}
