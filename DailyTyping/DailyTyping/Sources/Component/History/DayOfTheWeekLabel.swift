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
        setAttributedString(text: title, font: .pretendard(type: .Regular, size: 10), lineHeight: 12, charSpacing: -0.04)
        textAlignment = .center
        
        if dayOfTheWeek == .Sun {
            textColor = .primaryRed
        }
        
        myIntrinsicSize = CGSize(width: 30, height: 12)
    }
}
