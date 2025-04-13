//
//  SharePopupViewController.swift
//  DailyTyping
//
//  Created by 조유진 on 4/13/25.
//

import UIKit

enum Share: CaseIterable {
    case kakaotalk
    case copyURL
    
    var title: String {
        switch self {
        case .kakaotalk: "카카오톡"
        case .copyURL: "URL 복사"
        }
    }
    
    var image: UIImage {
        switch self {
        case .kakaotalk: .snsIc50Kakao
        case .copyURL: .snsIc50Url
        }
    }
}

final class SharePopupViewController: UIViewController {
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .inversePrimaryEmphasis
        return view
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.setAttributedString(text: "공유하기", font: .pretendard(type: .Medium, size: 18), lineHeight: 27, charSpacing: -0.01)
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = .iconClose
        config.background.backgroundColor = .clear
        config.baseForegroundColor = .primaryEmphasis
        button.configuration = config
        return button
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let shareItemlist: [Share]
    
    init(shareItemlist: [Share] = Share.allCases) {
        self.shareItemlist = shareItemlist
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        configureView()
    }
    
    private func configureLayout() {
        view.addSubview(contentView, autoLayout: [.bottom(0), .leading(0), .trailing(0)])
        contentView.addSubview(headerView, autoLayout: [.top(0), .leading(0), .trailing(0), .height(60)])
        headerView.addSubview(titleLabel, autoLayout: [.leading(20), .centerY(0)])
        headerView.addSubview(closeButton, autoLayout: [.trailing(20), .centerY(0), .width(24), .height(24)])
        contentView.addSubview(buttonStackView, autoLayout: [.topNext(to: headerView, constant: 20), .leading(20), .bottomLessThan(40)])
        
        for share in shareItemlist {
            let button = makeShareButton(share: share)
            buttonStackView.addArrangedSubview(button)
        }
    }
    
    private func configureView() {
        view.backgroundColor = .primaryEmphasis.withAlphaComponent(0.5)
    }
}

extension SharePopupViewController {
    private func makeShareButton(share: Share) -> UIButton {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = share.image
        config.attributedTitle = AttributedString(share.title, attributes: AttributeContainer([
            .font: UIFont.pretendard(type: .Medium, size: 14),
            .foregroundColor: UIColor.primaryEmphasis
        ]))
        config.imagePadding = 11
        button.configuration = config
        button.frame.size = CGSize(width: 152, height: 50)
        return button
    }
}
