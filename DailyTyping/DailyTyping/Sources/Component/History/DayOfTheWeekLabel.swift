//
//  DayOfTheWeekLabel.swift
//  DailyTyping
//
//  Created by 조유진 on 2/25/25.
//

import UIKit

final class DayOfTheWeekLabel: UILabel {
    var myIntrinsicSize: CGSize = .zero
    override var intrinsicContentSize: CGSize {
        return myIntrinsicSize
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(dayOfTheWeek: DayOfTheWeek) {
        let title = dayOfTheWeek.rawValue
        text = title
        setAttribute(text: title, font: .pretendard(type: .Regular, size: 10), lineHeight: 12, charSpacing: -0.04)
        
        
        if dayOfTheWeek == .Sun {
            textColor = .primaryRed
        }
        
        textAlignment = .center
        
        myIntrinsicSize = CGSize(width: 30, height: 12)
    }
    
    func setAttribute(text: String?, color: UIColor = .primaryEmphasis, font: UIFont? = .pretendard(type: .Light, size: 13), lineHeight: CGFloat = 30, charSpacing: CGFloat = -0.04) {
        guard let text, let font else { return }
        
        let resultText = text.isEmpty ? "\u{200B}" : text

        let style = NSMutableParagraphStyle()
        style.maximumLineHeight = lineHeight
        style.minimumLineHeight = lineHeight
        style.alignment = .center

        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: style,
            .baselineOffset: (lineHeight - font.lineHeight) / 2,
            .kern: charSpacing,
            .font: font,
            .foregroundColor: color,
        ]

        let attrString = NSAttributedString(string: resultText, attributes: attributes)
        self.attributedText = attrString
    }
}
