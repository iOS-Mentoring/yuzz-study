//
//  UITextView+attributedString.swift
//  DailyTyping
//
//  Created by 조유진 on 2/8/25.
//

import UIKit

extension UITextView {
    func setAttributedString(text: String? = "", color: UIColor = .gray300, lineHeight: CGFloat = 30, charSpacing: CGFloat = -0.04, font: UIFont? = .pretendard(type: .Regular, size: 20)) {
        guard let text, let font else { return }
        
        let resultText = text.isEmpty ? "\u{200B}" : text

        let style = NSMutableParagraphStyle()
        style.maximumLineHeight = lineHeight
        style.minimumLineHeight = lineHeight
    
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: style,
            .baselineOffset: (lineHeight - font.lineHeight) / 2,
            .kern: charSpacing,
            .font: font,
            .foregroundColor: color
        ]

        let attrString = NSAttributedString(string: resultText, attributes: attributes)
        self.attributedText = attrString
    }
}

