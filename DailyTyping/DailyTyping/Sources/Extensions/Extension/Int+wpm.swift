//
//  Int+wpm.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//

extension Int {
    func getWPM(characterCount: Int) -> Int {
        let minutes = Double(self) / 60.0
        let wpm = minutes > 0 ? Double(characterCount) / minutes : 0
        return Int(wpm.rounded())
    }
}
