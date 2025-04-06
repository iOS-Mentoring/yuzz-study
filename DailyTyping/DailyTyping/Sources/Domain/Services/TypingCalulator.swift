//
//  TypingCalulator.swift
//  DailyTyping
//
//  Created by 조유진 on 4/6/25.
//

import Foundation
import UIKit

protocol TypingCalulator {
    func getMatchHangulCharacterCount(text: String, pilsaMessage: String) -> Int
    func isMatchHangulCharacter(text: String, pilsaMessage: String) -> Bool
    func getCharacterList(string: String) -> [Character]
    func calculateAcc(text: String, pilsaMessage: String) -> Int
    func validateCharacter(text: String, pilsaMessage: String) -> NSAttributedString
    func getEnumeratedList(_ string: String) -> Array<(offset: Int, element: Character)>
    func getWPM(second: Int, characterCount: Int) -> Int
}

final class TypingCalulatorImpl: TypingCalulator {
    func getMatchHangulCharacterCount(text: String, pilsaMessage: String) -> Int {
        let inputCharList = getCharacterList(string: text)
        let placeholderCharList = getCharacterList(string: pilsaMessage)
        
        var matchCount = 0
        
        for i in 0..<placeholderCharList.count {
            if let inputCharacter = inputCharList[safe: i], let placeholderCharacter = placeholderCharList[safe: i], inputCharacter == placeholderCharacter {
                matchCount += 1
            }
        }
        
        return matchCount
    }
    
    func isMatchHangulCharacter(text: String, pilsaMessage: String) -> Bool {
        let inputCharList = getCharacterList(string: text)
        let placeholderCharList = getCharacterList(string: pilsaMessage)
        
        for i in 0..<placeholderCharList.count {
            guard let inputCharacter = inputCharList[safe: i], let placeholderCharacter = placeholderCharList[safe: i] else { return false }
            if inputCharacter != placeholderCharacter { return false }
        }
        
        return true
    }
    
    func getCharacterList(string: String) -> [Character] {
        return string.decomposedStringWithCanonicalMapping.unicodeScalars.map { scalar -> Character in Character(scalar) }
    }
    
    func calculateAcc(text: String, pilsaMessage: String) -> Int {
        Int((Double(getMatchHangulCharacterCount(text: text, pilsaMessage: pilsaMessage)) / Double(getCharacterList(string: TypingLabelText.typingValue.rawValue).count) * 100).rounded())
    }
    
    func validateCharacter(text: String, pilsaMessage: String) -> NSAttributedString {
        let lineHeight = 30.0
        let charSpacing = -0.04
        let textFont: UIFont = .pretendard(type: .Regular, size: 20)
        
        let attributedString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.maximumLineHeight = lineHeight
        style.minimumLineHeight = lineHeight
    
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: style,
            .baselineOffset: (lineHeight - textFont.lineHeight) / 2,
            .kern: charSpacing,
            .font: textFont,
            .foregroundColor: UIColor.black
        ]
        
        attributedString.addAttributes(attributes, range: NSRange(location: 0, length: attributedString.length))

       
        for (index, inputChar) in getEnumeratedList(text) {
            let range = NSRange(location: index, length: 1)
            
            if index >= pilsaMessage.count {
                attributedString.addAttribute(.foregroundColor, value: UIColor.primaryRed, range: range)
                continue
            }
            
            let pilsaIndex = pilsaMessage.index(pilsaMessage.startIndex, offsetBy: index)
            let targetChar = pilsaMessage[pilsaIndex]
            let color: UIColor = inputChar == targetChar ? .primaryEmphasis : .primaryRed
            attributedString.addAttribute(.foregroundColor, value: color, range: range)
        }
        return attributedString
    }
    
    func getEnumeratedList(_ string: String) -> Array<(offset: Int, element: Character)> {
        return Array(string.enumerated())
    }
    
    func getWPM(second: Int, characterCount: Int) -> Int {
        let minutes = Double(second) / 60.0
        let wpm = minutes > 0 ? Double(characterCount) / minutes : 0
        return Int(wpm.rounded())
    }
}
