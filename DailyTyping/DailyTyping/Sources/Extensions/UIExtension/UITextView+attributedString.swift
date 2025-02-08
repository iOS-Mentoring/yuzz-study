//
//  UITextView+attributedString.swift
//  DailyTyping
//
//  Created by 조유진 on 2/8/25.
//

import UIKit

extension UITextView {
    func setAttributedString(text: String?, lineHeight: CGFloat = 30, charSpacing: Double = -0.03) {
        guard let text = text else { return }

        let style = NSMutableParagraphStyle()
        style.maximumLineHeight = lineHeight
        style.minimumLineHeight = lineHeight
        
        let fontSize = self.font?.pointSize ?? 20
        let kernValue = fontSize * CGFloat(charSpacing)

        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: style,
            .kern: kernValue
        ]

        let attrString = NSAttributedString(string: text, attributes: attributes)
        self.attributedText = attrString
    }
}
