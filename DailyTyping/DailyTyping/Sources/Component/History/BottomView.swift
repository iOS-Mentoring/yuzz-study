//
//  BottomBackgroundView.swift
//  DailyTyping
//
//  Created by 조유진 on 2/25/25.
//

import UIKit

final class BottomView: BaseView {
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .primaryEmphasis
        return view
    }()
    
    private let haruImageView: UIImageView = {
        let imageView = UIImageView(image: .illustHaruWhole)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let downloadButton: CircleButton = {
        let button = CircleButton()
        button.configureView(buttonType: .download)
        return button
    }()
    
    let shareButton: CircleButton = {
        let button = CircleButton()
        button.configureView(buttonType: .share)
        return button
    }()
    
    override func configureLayout() {
        addSubview(backgroundView, autoLayout: [.bottom(0), .leading(0), .trailing(0), .height(100)])
        addSubview(haruImageView, autoLayout: [.trailing(0), .bottomEqual(to: backgroundView, constant: 60)])
        addSubview(downloadButton, autoLayout: [.leadingSafeArea(20), .bottomSafeArea(12), .width(36), .height(36)])
        addSubview(shareButton, autoLayout: [.leadingNext(to: downloadButton, constant: 12), .bottomSafeArea(12), .width(36), .height(36)])
    }
    
    override func configureView() { }
}
