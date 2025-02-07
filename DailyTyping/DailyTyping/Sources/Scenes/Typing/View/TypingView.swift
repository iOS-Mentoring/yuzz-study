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
        let title = "하루필사"
        label.text = title
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
    
    
    override func configureLayout() {
        addSubview(dtNavigationBar, autoLayout: [.leadingSafeArea(0), .topSafeArea(0), .trailingSafeArea(0), .height(60)])
    }

    override func configureView() {
        super.configureView()
        
        dtNavigationBar.setNavigationItem(titleLabel: navigationTitleLabel, rightButton: historyButton)
    }
}
