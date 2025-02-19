//
//  Date+EnglishStyleFormatter.swift
//  DailyTyping
//
//  Created by 조유진 on 2/19/25.
//

import Foundation

public extension Date {
    
    var toEnglishStyleDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US") // 한국어 로케일 설정
        dateFormatter.dateFormat = "MMM dd" // 원하는 포맷 설정
        return dateFormatter.string(from: self)
    }
}
