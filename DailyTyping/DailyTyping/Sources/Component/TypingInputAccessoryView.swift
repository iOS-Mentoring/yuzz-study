//
//  Untitled.swift
//  DailyTyping
//
//  Created by 조유진 on 2/8/25.
//

import UIKit

final class TypingInputAccessoryView: BaseView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = LabelText.defaultTitle.rawValue
        label.font = .pretendard(type: .Bold, size: 13)
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.text = LabelText.author.rawValue
        label.font = .pretendard(type: .Bold, size: 13)
        return label
    }()
    
    private let linkButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.image = .iconLink.resized(to: CGSize(width: 24, height: 24))
        button.configuration = configuration
        return button
    }()
    
    override func configureLayout() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(authorLabel)
        addSubview(linkButton, autoLayout: [.trailing(20), .top(11), .bottom(12)])
        addSubview(stackView, autoLayout: [.leading(20), .top(11), .bottom(12), .trailingEqualLessThan(to: linkButton, constant: 20)])
    }
    
    override func configureView() {
        backgroundColor = .gray100
        addBorder(to: [.top], color: .primaryEmphasis, width: 1)
    }
}
