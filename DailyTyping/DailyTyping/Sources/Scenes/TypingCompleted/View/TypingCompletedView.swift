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
    
    private let typingCompletedHeaderView = TypingCompletedHeaderView()
    private let typingResultView = TypingResultView()
    private let pilsaInfoView = PilsaInfoView()
    private let downloadImageButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.pretendard(type: .SemiBold, size: 16)
        configuration.baseBackgroundColor = .primaryEmphasis
        configuration.image = .iconInverseDownload
        configuration.title = TypingCompletedLabelText.downloadImage.rawValue
        configuration.attributedTitle = AttributedString(TypingCompletedLabelText.downloadImage.rawValue, attributes: titleContainer)
        configuration.baseForegroundColor = .white
        button.configuration = configuration
        button.backgroundColor = .primaryEmphasis
        return button
    }()
    private let bottomBlackView: UIView = {
        let view = UIView()
        view.backgroundColor = .primaryEmphasis
        return view
    }()
    
    override func configureLayout() {
        addSubview(typingCompletedHeaderView, autoLayout: [.topSafeArea(40), .leading(0), .trailing(0), .height(140)])
        
        addSubview(typingResultView, autoLayout: [.topNext(to: typingCompletedHeaderView, constant: 40), .leading(20), .trailing(20)])
        
        addSubview(pilsaInfoView, autoLayout: [.topNext(to: typingResultView, constant: 40), .leading(20), .trailing(20)])
        
        addSubview(downloadImageButton, autoLayout: [.leadingSafeArea(0), .trailingSafeArea(0), .bottomSafeArea(0), .height(70)])
        addSubview(bottomBlackView, autoLayout: [.leadingSafeArea(0), .trailingSafeArea(0), .bottom(0), .topNext(to: downloadImageButton, constant: 0)])
    }
    
    override func configureView() {
        super.configureView()
    }
    
    func setTypingResultData() {
        
    }
    
    func setTypingResultViewBorder() {
        typingResultView.layer.addBorder(to: [.top, .bottom], width: 1)
    }
}
