//
//  String+character.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//

import Foundation

extension String {
    func getMatchHangulCharacterCount() -> Int {
        let inputCharList = getCharacterList(string: self)
        let placeholderCharList = getCharacterList(string: TypingLabelText.typingValue.rawValue)
        
        var matchCount = 0
        
        for i in 0..<placeholderCharList.count {
            if let inputCharacter = inputCharList[safe: i], let placeholderCharacter = placeholderCharList[safe: i], inputCharacter == placeholderCharacter {
                matchCount += 1
            }
        }
        
        return matchCount
    }
    
    func isMatchHangulCharacter() -> Bool {
        let inputCharList = getCharacterList(string: self)
        let placeholderCharList = getCharacterList(string: TypingLabelText.typingValue.rawValue)
        
        for i in 0..<placeholderCharList.count {
            guard let inputCharacter = inputCharList[safe: i], let placeholderCharacter = placeholderCharList[safe: i] else { return false }
            if inputCharacter != placeholderCharacter { return false }
        }
        
        return true
    }
    
    func getCharacterList(string: String) -> [Character] {
        return string.decomposedStringWithCanonicalMapping.unicodeScalars.map { scalar -> Character in Character(scalar) }
    }
}
