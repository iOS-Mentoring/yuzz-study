//
//  TypingView.swift
//  DailyTyping
//
//  Created by 조유진 on 2/8/25.
//

import UIKit

final class TypingView: BaseView {
    let navigationTitleLabel: UILabel = {
        let label = UILabel()
        let title = TypingLabelText.navigationTitle.rawValue
        label.text = title
        label.setAttributedString(
            text: title,
            color: .primaryEmphasis,
            font: .nanumMyeongjo(type: .Regular, size: 22),
            lineHeight: 27,
            charSpacing: -0.02
        )
        return label
    }()
    
    let historyButton: UIButton = {
       let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.image = .iconHistory.resized(to: CGSize(width: 24, height: 24))
        button.configuration = configuration
        
        return button
    }()
    
    private let speedMeasurementView = SpeedMeasurementView()
    private let placeholderTextView = PlaceholderTextView()
    let typingTextView = PlaceholderTextView()
    let typingInputAccessoryView = TypingInputAccessoryView()
    
    
    override func configureLayout() {
        addSubview(speedMeasurementView, autoLayout: [.topSafeArea(40), .leadingSafeArea(0), .trailingSafeArea(0), .height(30)])
        addSubview(placeholderTextView, autoLayout: [.topNext(to: speedMeasurementView, constant: 0), .leadingSafeArea(0), .trailingSafeArea(0), .bottomSafeArea(0)])
        addSubview(typingTextView, autoLayout: [.topNext(to: speedMeasurementView, constant: 0), .leadingSafeArea(0), .trailingSafeArea(0), .bottomSafeArea(0)])
        addSubview(typingInputAccessoryView, autoLayout: [.height(55)])
    }

    override func configureView() {
        super.configureView()
        
        placeholderTextView.configureView(textValue: TypingLabelText.typingValue.rawValue)
        typingTextView.configureView(textValue: nil, isPlaceHolder: false)
        typingTextView.inputAccessoryView = typingInputAccessoryView
        typingTextView.autocorrectionType = .no
        setTextViewFirstResponder()
    }
    
    func setTextViewFirstResponder() {
        typingTextView.becomeFirstResponder()
    }
    
    func addBorderToTypingInfoView() {
        typingInputAccessoryView.addBorderToTypingInfoView()
    }
    
    func setElapsedTime(second: Int) {
        speedMeasurementView.setElapsedTime(second: second)
    }
    
    func startProgressView() {
        speedMeasurementView.startProgressView()
    }
    
    func setProgressLayout(second: Int) {
        speedMeasurementView.setProgressLayout(second: second)
    }
    
    func setWPMValue(wpm: Int) {
        speedMeasurementView.setWPMValue(wpm: wpm)
    }
}
