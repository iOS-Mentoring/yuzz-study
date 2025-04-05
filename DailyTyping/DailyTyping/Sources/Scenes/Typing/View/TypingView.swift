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
    private let placeholderTextView = PilsaTextView()
    let typingTextView = PilsaTextView()
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
        typingTextView.configureView(textValue: "", isPlaceHolder: false)
        typingTextView.inputAccessoryView = typingInputAccessoryView
        typingTextView.autocorrectionType = .no
        setTextViewFirstResponder()
    }
    
    func setPilsaInfo(_ pilsaInfo: PilsaInfo) {
        placeholderTextView.configureView(textValue: pilsaInfo.message)
        typingInputAccessoryView.setPilsaInfo(pilsaInfo)
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
    
    func isEditableTextView(_ isEditable: Bool) {
        typingTextView.isEditable = isEditable
    }
    
    func setValidAttributedString(_ attributedString: NSAttributedString) {
        typingTextView.setValidAttributedString(attributedString)
    }
    
    func setTypingTextViewIsEditable(_ isEditable: Bool) {
        typingTextView.isEditable = isEditable
    }
}

extension TypingView {
    func setTextViewContentInset(keyboardHeight: CGFloat) {
        var inset = typingTextView.contentInset
        inset.bottom = keyboardHeight
        [placeholderTextView, typingTextView].forEach { $0.contentInset = inset }
        [placeholderTextView, typingTextView].forEach { $0.scrollIndicatorInsets = inset }
    }
    
    func setTextViewAutoScroll() {
        guard let selectedRange = typingTextView.selectedTextRange else { return }
        
        let caretRect = typingTextView.caretRect(for: selectedRange.end)
        
        let visibleRect = typingTextView.bounds.inset(by: typingTextView.contentInset)
        
        let offsetCaretRect = caretRect.offsetBy(
            dx: -typingTextView.contentOffset.x,
            dy: -typingTextView.contentOffset.y
        )
        
        if !visibleRect.contains(offsetCaretRect) {
            DispatchQueue.main.async {
                self.typingTextView.scrollRectToVisible(caretRect, animated: true)
            }
            scrollPlaceholderTextView(offset: typingTextView.contentOffset)
        }
    }
    
    func scrollPlaceholderTextView(offset: CGPoint) {
        placeholderTextView.contentOffset = offset
    }
    
    func setTextViewIsHiddenInset(_ isHidden: Bool) {
        if isHidden {
            [placeholderTextView, typingTextView].forEach {
                $0.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            }
        }
    }
}
