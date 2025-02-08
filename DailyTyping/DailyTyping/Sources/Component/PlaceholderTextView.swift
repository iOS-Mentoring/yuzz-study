//
//  Untitled.swift
//  DailyTyping
//
//  Created by 조유진 on 2/8/25.
//

import UIKit

final class PlaceholderTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(textValue: String = LabelText.typingValue.rawValue, color textColor: UIColor? = UIColor.gray300, backgroundColor: UIColor? = UIColor.gray100, font: UIFont? = UIFont.pretendard(type: .Regular, size: 20), isPlaceHolder: Bool = true, containerInset: Double = 20) {
        self.text = textValue
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.font = font
//        setAttributedString(text: text, lineHeight: 30, charSpacing: -0.03)
        textContainerInset = UIEdgeInsets(top: containerInset, left: containerInset, bottom: containerInset, right: containerInset)
        isEditable = !isPlaceHolder
        isSelectable = !isPlaceHolder
    }
}
