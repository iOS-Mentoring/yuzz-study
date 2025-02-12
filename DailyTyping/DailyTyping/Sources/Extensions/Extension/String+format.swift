//
//  String+format.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//

extension String {
    static func getFormattedTwoDigit(number: Int) -> String {
        return String(format: "%02d", number)
    }
}
