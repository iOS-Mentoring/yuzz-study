//
//  PilsaInfoView.swift
//  DailyTyping
//
//  Created by 조유진 on 2/14/25.
//

import UIKit

final class PilsaInfoView: BaseView {
    private let typingTextStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.design(alignment: .leading, spacing: 20)
        return stackView
    }()
    private let doubleQuotesImageView: UIImageView = {
        let imageView = UIImageView(image: .iconDoubleQuotes)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let typingTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let typingInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.design(spacing: 6)
        return stackView
    }()
    
    private let typingTitleLabel: UILabel = {
        let label = UILabel()
        let title = ""
        label.text = title
        label.setAttributedString(text: title, font: .pretendard(type: .SemiBold, size: 16), lineHeight: 19)
        return label
    }()
    
    private let typingAuthorLabel: UILabel = {
        let label = UILabel()
        let title = ""
        label.text = title
        label.setAttributedString(text: title, font: .pretendard(type: .Regular, size: 12), lineHeight: 16)
        return label
    }()
    
    
    override func configureLayout() {
        [doubleQuotesImageView, typingTextLabel].forEach {
            typingTextStackView.addArrangedSubview($0)
        }
        
        [typingTitleLabel, typingAuthorLabel].forEach {
            typingInfoStackView.addArrangedSubview($0)
        }
        
        addSubview(typingTextStackView, autoLayout: [.top(0), .leading(0), .trailing(0)])
        addSubview(typingInfoStackView, autoLayout: [.topNext(to: typingTextStackView, constant: 30), .leading(0), .trailingLessThan(0), .bottom(0)])
    }
}

extension PilsaInfoView {
    func setPilsaInfo(_ pilsaInfo: PilsaInfo) {
        setTitle(pilsaInfo.title)
        setAuthor(pilsaInfo.author)
        setPilsaText(pilsaInfo.message)
    }
    
    func setPilsaText(_ message: String) {
        print(message)
        typingTextLabel.text = message
        typingTextLabel.setAttributedString(text: message, font: .pretendard(type: .Regular, size: 18), lineHeight: 28, charSpacing: -0.04)
    }
    
    func setTitle(_ title: String) {
        typingTitleLabel.text = title
        typingTextLabel.setAttributedString(text: title, font: .pretendard(type: .SemiBold, size: 16), lineHeight: 19)
    }
    
    func setAuthor(_ author: String) {
        typingAuthorLabel.text = author
        typingAuthorLabel.setAttributedString(text: author, font: .pretendard(type: .Regular, size: 12), lineHeight: 16)
    }
}
