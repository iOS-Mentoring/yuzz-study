//
//  ResultTitleLabel.swift
//  DailyTyping
//
//  Created by 조유진 on 2/14/25.
//

import UIKit

final class ResultTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func configureView(title: String) {
        setAttributedString(text: title, font: .pretendard(type: .Regular, size: 11), lineHeight: 14, charSpacing: -0.025)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
