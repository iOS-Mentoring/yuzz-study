//
//  UILabel+attributedString.swift
//  DailyTyping
//
//  Created by 조유진 on 2/8/25.
//

import UIKit

extension UILabel {
    func setAttributedString(text: String?, lineHeight: CGFloat = 30, charSpacing: Double = -0.03) {
        guard let text = text else { return }

        let style = NSMutableParagraphStyle()
        style.maximumLineHeight = lineHeight
        style.minimumLineHeight = lineHeight
        
        let kernValue = self.font.pointSize * CGFloat(charSpacing)

        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: style,
            .kern: kernValue
        ]

        let attrString = NSAttributedString(string: text, attributes: attributes)
        self.attributedText = attrString
    }
}
