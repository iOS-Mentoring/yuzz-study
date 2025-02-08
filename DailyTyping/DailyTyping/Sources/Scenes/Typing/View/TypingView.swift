//
//  TypingView.swift
//  DailyTyping
//
//  Created by 조유진 on 2/8/25.
//

import UIKit

final class TypingView: BaseView {
    private let navigationTitleLabel: UILabel = {
        let label = UILabel()
        let title = TypingLabelText.navigationTitle.rawValue
        label.text = title
        label.textColor = .primaryEmphasis
        label.font = .nanumMyeongjo(type: .Regular, size: 22)
        return label
    }()
    
    private let historyButton: UIButton = {
       let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.image = .iconHistory.resized(to: CGSize(width: 24, height: 24))
        button.configuration = configuration
        
        return button
    }()
    
    private let dtNavigationBar = DTNavigationBar()
    
    private let speedMeasurementView = SpeedMeasurementView()
    private let placeholderTextView = PlaceholderTextView()
    private let typingTextView = PlaceholderTextView()
    private let typingInputAccessoryView = TypingInputAccessoryView()
    
    
    override func configureLayout() {
        addSubview(dtNavigationBar, autoLayout: [.leadingSafeArea(0), .topSafeArea(0), .trailingSafeArea(0), .height(60)])
        addSubview(speedMeasurementView, autoLayout: [.topNext(to: dtNavigationBar, constant: 0), .leadingSafeArea(0), .trailingSafeArea(0), .height(30)])
        addSubview(placeholderTextView, autoLayout: [.topNext(to: speedMeasurementView, constant: 0), .leadingSafeArea(0), .trailingSafeArea(0), .bottomSafeArea(0)])
        addSubview(typingTextView, autoLayout: [.topNext(to: speedMeasurementView, constant: 0), .leadingSafeArea(0), .trailingSafeArea(0), .bottomSafeArea(0)])
        addSubview(typingInputAccessoryView, autoLayout: [.height(55)])
    }

    override func configureView() {
        super.configureView()
        
        dtNavigationBar.setNavigationItem(titleLabel: navigationTitleLabel, rightButton: historyButton)
        placeholderTextView.configureView(textValue: TypingLabelText.typingValue.rawValue)
        typingTextView.configureView(textValue: "", isPlaceHolder: false)
        typingTextView.inputAccessoryView = typingInputAccessoryView
        setTextViewFirstResponder()
    }
    
    private func setTextViewFirstResponder() {
        typingTextView.becomeFirstResponder()
    }
    
    func addBorderToTypingInfoView() {
        typingInputAccessoryView.addBorderToTypingInfoView()
    }
}
