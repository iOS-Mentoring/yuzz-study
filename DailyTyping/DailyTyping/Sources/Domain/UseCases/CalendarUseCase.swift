//
//  CalendarUseCase.swift
//  DailyTyping
//
//  Created by 조유진 on 4/6/25.
//

import Foundation

protocol CalendarUseCase {
    func getCurrentWeekDates() -> [Date]
}

final class CalendarUseCaseImpl: CalendarUseCase {
    func getCurrentWeekDates() -> [Date] {
        var calendar = Calendar.current
        calendar.firstWeekday = 1   // 일요일부터 시작
        
        let today = Date()
        
        guard let weekday = calendar.dateComponents([.weekday], from: today).weekday else {
            return []
        }
        
        let offsetToSunday = calendar.firstWeekday - weekday
        
        guard let thisSunday = calendar.date(byAdding: .day, value: offsetToSunday, to: today) else {
            return []
        }
        
        var weekDates: [Date] = []
        
        for i in 0..<7  {
            if let targetDate = calendar.date(byAdding: .day, value: i, to: thisSunday) {
                weekDates.append(targetDate)
            }
        }
        
        return weekDates
    }
}
