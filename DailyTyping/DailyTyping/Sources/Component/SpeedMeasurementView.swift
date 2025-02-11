//
//  SpeedMeasurementView.swift
//  DailyTyping
//
//  Created by 조유진 on 2/8/25.
//

import UIKit

final class SpeedMeasurementView: BaseView {
    private let gageView: UIView = {
       let view = UIView()
        view.backgroundColor = .primaryRed
        
        return view
    }()
    
    private let wpmLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .inversePrimaryEmphasis
        label.font = .pretendard(type: .Light, size: 13)
        
        let title = TypingLabelText.wpm.rawValue
        let value = "0"
       
        let attributedString = NSMutableAttributedString(string: title + " " + value)
        attributedString.addAttribute(.font, value: UIFont.pretendard(type: .Bold, size: 13), range: NSRange(location: title.count+1, length: value.count))
        label.attributedText = attributedString
       
        return label
    }()
    
    private let progressTimeLabel: UILabel = {
        let label = UILabel()
        let title = "00:00:00"
        label.text = title
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 13, weight: .regular)
        label.setAttributedString(
            text: title,
            color: .inversePrimaryEmphasis,
            font: UIFont.monospacedDigitSystemFont(ofSize: 13, weight: .regular),
            charSpacing: -0.03
        )
       
        return label
    }()

    
    override func configureLayout() {
        addSubview(gageView, autoLayout: [.leading(0), .top(0), .bottom(0), .trailingLessThan(40), .widthLessThan(80), .height(30)])
        addSubview(wpmLabel, autoLayout: [.leading(20), .centerY(0)])
        addSubview(progressTimeLabel, autoLayout: [.trailing(20), .centerY(0)])
    }
    
    override func configureView() {
        backgroundColor = .primaryEmphasis
    }

}
