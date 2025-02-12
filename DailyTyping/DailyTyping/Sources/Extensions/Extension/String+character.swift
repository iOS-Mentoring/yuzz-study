//
//  String+character.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//

import Foundation

extension String {
    func getMatchHangulCharacterCount() -> Int {
        var inputCharList = self.decomposedStringWithCanonicalMapping
            .unicodeScalars
            .map { scalar -> Character in
                return Character(scalar)
            }
        
        inputCharList.removeFirst()
        
        let placeholderCharList = TypingLabelText.typingValue.rawValue.decomposedStringWithCanonicalMapping
            .unicodeScalars
            .map { scalar -> Character in
                return Character(scalar)
            }
        
        var matchCount = 0
        
        for i in 0..<placeholderCharList.count {
            if let inputCharacter = inputCharList[safe: i], let placeholderCharacter = placeholderCharList[safe: i], inputCharacter == placeholderCharacter {
                matchCount += 1
            }
        }
        
        return matchCount
    }
    
    func isSameCountWithPlaceholder() -> Bool {
        return self.count == TypingLabelText.typingValue.rawValue.count
    }
}
