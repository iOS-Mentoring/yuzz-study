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
    
    override func configureLayout() {
        addSubview(typingCompletedHeaderView, autoLayout: [.topSafeArea(40), .leading(0), .trailing(0), .height(140)])
        
        addSubview(typingResultView, autoLayout: [.topNext(to: typingCompletedHeaderView, constant: 40), .leading(20), .trailing(20)])
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
