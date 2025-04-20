//
//  ContentButton.swift
//  DailyTyping
//
//  Created by 조유진 on 4/20/25.
//

import UIKit

final class ContentButtonView: UIView {
    private let titleLabel = UILabel()
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView(image: .iconArrowDownThinMono1)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let contentImageView = UIImageView()
    
    init(content: Content) {
        super.init(frame: .zero)
        configureLayout()
        configureView(content: content)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        self.addSubview(titleLabel, autoLayout: [.top(21), .leading(20)])
        self.addSubview(arrowImageView, autoLayout: [.topEqual(to: titleLabel, constant: -1), .leadingNext(to: titleLabel, constant: 0), .width(22), .height(22)])
        self.addSubview(contentImageView, autoLayout: [.bottom(20), .trailing(20), .width(48), .height(48)])
    }
    
    private func configureView(content: Content) {
        titleLabel.setAttributedString(
            text: content.title,
            color: .inversePrimaryEmphasis,
            font: .pretendard(type: .Regular, size: 16),
            lineHeight: 21,
            charSpacing: -0.03
        )
        contentImageView.image = content.image
        contentImageView.contentMode = .scaleAspectFit
        self.backgroundColor = .primaryEmphasis
    }
}
