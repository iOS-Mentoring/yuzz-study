//
//  DayLabel.swift
//  DailyTyping
//
//  Created by 조유진 on 2/25/25.
//

import UIKit

final class DayLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureView(day: String) {
        setAttributedString(text: day, font: .pretendard(type: .SemiBold, size: 14), lineHeight: 12)
        textAlignment = .center
    }
}
