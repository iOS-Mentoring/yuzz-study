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
    
    private let typingTitleLabel = UILabel()
    
    private let typingAuthorLabel = UILabel()
    
    
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
    
    override func configureView() { }
}

extension PilsaInfoView {
    func setPilsaInfo(_ pilsaInfo: PilsaInfo) {
        setTitle(pilsaInfo.title)
        setAuthor(pilsaInfo.author)
        setPilsaText(pilsaInfo.message)
    }
    
    private func setPilsaText(_ message: String) {
        typingTextLabel.setAttributedString(text: message, font: .pretendard(type: .Regular, size: 18), lineHeight: 28, charSpacing: -0.04)
    }
    
    private func setTitle(_ title: String) {
        typingTextLabel.setAttributedString(text: title, font: .pretendard(type: .SemiBold, size: 16), lineHeight: 19)
    }
    
    private func setAuthor(_ author: String) {
        typingAuthorLabel.setAttributedString(text: author, font: .pretendard(type: .Regular, size: 12), lineHeight: 16)
    }
}
