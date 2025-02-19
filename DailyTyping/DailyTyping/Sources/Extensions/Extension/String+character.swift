//
//  String+character.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//

import UIKit

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
    
    func validateCharacter() -> NSAttributedString {
        let pilsaList = TypingLabelText.typingValue.rawValue
        let lineHeight = 30.0
        let charSpacing = -0.04
        let textFont: UIFont = .pretendard(type: .Regular, size: 20)
        
        let attributedString = NSMutableAttributedString(string: self)
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

       
        for (index, inputChar) in getEnumeratedList(self) {
            let range = NSRange(location: index, length: 1)
            
            if index >= pilsaList.count {
                continue
            }
            
            let pilsaIndex = pilsaList.index(pilsaList.startIndex, offsetBy: index)
            let targetChar = pilsaList[pilsaIndex]
            
            let color: UIColor = inputChar == targetChar ? .primaryEmphasis : .primaryRed
            attributedString.addAttribute(.foregroundColor, value: color, range: range)
        }
        return attributedString
    }
    
    func isSameCountWithPlaceholder() -> Bool {
        return getEnumeratedList(self).count == getEnumeratedList(TypingLabelText.typingValue.rawValue).count
    }
    
    func getEnumeratedList(_ string: String) -> Array<(offset: Int, element: Character)> {
        return Array(string.enumerated())
    }
}
