//
//  SpeedMeasurementView.swift
//  DailyTyping
//
//  Created by 조유진 on 2/8/25.
//

import UIKit

final class SpeedMeasurementView: BaseView {
    private let progressView: UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    private let wpmLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .inversePrimaryEmphasis
        label.font = .pretendard(type: .Light, size: 13)
        
        let title = TypingLabelText.wpm.rawValue
        let value = "0"
       
        let attributedString = NSMutableAttributedString(string: title + " " + value)
        attributedString.addAttribute(
            .font,
            value: UIFont.pretendard(type: .Bold, size: 13),
            range: NSRange(
                location: title.count + 1,
                length: value.count
            )
        )
        label.attributedText = attributedString
       
        return label
    }()
    
    private let progressTimeLabel: UILabel = {
        let label = UILabel()
        let title = "00:00:00"
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
        addSubview(progressView, autoLayout: [.leading(0), .top(0), .bottom(0), .trailing(0), .height(30)])
        addSubview(wpmLabel, autoLayout: [.leading(20), .centerY(0)])
        addSubview(progressTimeLabel, autoLayout: [.trailing(20), .centerY(0)])
    }
    
    override func configureView() {
        backgroundColor = .primaryEmphasis
    }

    func setElapsedTime(second: Int) {
        progressTimeLabel.text = getSecondText(second: second)
    }
    
    func getSecondText(second: Int) -> String {
        let resultSecond = getFormattedTwoDigit(number: second)
        return second != 60 ? "00:00:\(resultSecond)" : "00:01:00"
    }
    
    func getFormattedTwoDigit(number: Int) -> String {
        return String(format: "%02d", number)
    }
    
    func startProgressView() {
        progressView.backgroundColor = .primaryRed
    }
    
    func setProgressLayout(second: Int) {
        progressView.updateConstraint(of: .trailing, constant: -calculateWidth(second: second))
        UIView.animate(withDuration: 1) {
            self.layoutIfNeeded()
        }
    }
    
    func calculateWidth(second: Int) -> CGFloat {
        return UIScreen.width * CGFloat(second)/60.0
    }
    
    func setWPMValue(wpm: Int) {
        wpmLabel.textColor = .inversePrimaryEmphasis
        wpmLabel.font = .pretendard(type: .Light, size: 13)
        
        let title = TypingLabelText.wpm.rawValue
        let value = "\(wpm)"
       
        let attributedString = NSMutableAttributedString(string: title + " " + value)
        attributedString.addAttribute(
            .font,
            value: UIFont.pretendard(type: .Bold, size: 13),
            range: NSRange(
                location: title.count+1,
                length: value.count
            )
        )
        wpmLabel.attributedText = attributedString
    }
}
