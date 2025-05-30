//
//  PilsaTextView.swift
//  DailyTyping
//
//  Created by 조유진 on 2/8/25.
//

import UIKit

final class PilsaTextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(textValue: String? = nil, color textColor: UIColor? = UIColor.gray300, backgroundColor: UIColor? = UIColor.gray100, font: UIFont? = UIFont.pretendard(type: .Regular, size: 20), isPlaceHolder: Bool = true, containerInset: Double = 20) {
        self.backgroundColor = isPlaceHolder ? backgroundColor : .clear
        self.font = font
        isPlaceHolder ? setAttributedString(text: textValue) : setAttributedString(text: text, color: .primaryEmphasis)
        textContainerInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        contentInset = UIEdgeInsets(top: containerInset, left: 0, bottom: containerInset, right: 0)
        isEditable = !isPlaceHolder
        isSelectable = !isPlaceHolder
        isScrollEnabled = true
    }
    
    func setAttributedString(text: String?, color: UIColor = .gray300, lineHeight: CGFloat = 30, charSpacing: CGFloat = -0.04, font: UIFont? = .pretendard(type: .Regular, size: 20)) {
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
        attributedText = attrString
    }

    func setValidAttributedString(_ attributedString: NSAttributedString) {
        attributedText = attributedString
    }
}
