//
//  TypingCompletedHeaderView.swift
//  DailyTyping
//
//  Created by 조유진 on 2/14/25.
//

import UIKit

final class TypingCompletedHeaderView: BaseView {
    private let goodImageView: UIImageView = {
        let imageView = UIImageView(image: .illustHaruWhole)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let completedMessageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.design()
        return stackView
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureLayout() {
        [goodLabel, typingCompletedLabel].forEach {
            completedMessageStackView.addArrangedSubview($0)
        }
        
        addSubview(completedMessageStackView, autoLayout: [.top(70), .leading(20)])
        addSubview(goodImageView, autoLayout: [.top(12), .trailing(0), .width(110), .height(140)])
    }
}
