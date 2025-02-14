//
//  TypingCompletedView.swift
//  DailyTyping
//
//  Created by 조유진 on 2/14/25.
//

import UIKit

final class TypingCompletedView: BaseView {
    let closeButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.image = .iconClose.resized(to: CGSize(width: 30, height: 30))
        button.configuration = configuration
        return button
    }()
    
    private let completedMessageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.design()
        return stackView
    }()
    
    private let goodImageView: UIImageView = {
        let imageView = UIImageView(image: .illustHaruWhole)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let goodLabel: UILabel = {
        let label = UILabel()
        let title = TypingCompletedLabelText.good.rawValue
        label.text = title
        label.setAttributedString(text: title, font: .timesNewRoman(type: .italic, size: 50), lineHeight: 36, charSpacing: -0.05)
        return label
    }()
    
    private let typingCompletedLabel: UILabel = {
        let label = UILabel()
        let title = TypingCompletedLabelText.typingCompleted.rawValue
        label.text = title
        label.setAttributedString(text: title, font: .pretendard(type: .Medium, size: 16), lineHeight: 20, charSpacing: -0.03)
        return label
    }()
    
    override func configureLayout() {
        completedMessageStackView.addArrangedSubview(goodLabel)
        completedMessageStackView.addArrangedSubview(typingCompletedLabel)
        addSubview(completedMessageStackView, autoLayout: [.topSafeArea(110), .leading(20)])
        addSubview(goodImageView, autoLayout: [.topSafeArea(52), .trailing(0), .width(110), .height(140)])
    }
    
    override func configureView() {
        super.configureView()
    }
}
