//
//  TitlePopupViewController.swift
//  DailyTyping
//
//  Created by 조유진 on 4/13/25.
//

import UIKit

final class TitlePopupViewController: UIViewController {
    private let backgroundStackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .inversePrimaryEmphasis
        view.layer.cornerRadius = 10
        view.axis = .vertical
        view.alignment = .fill
        view.spacing = 0
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.backgroundColor = .gray
        return stackView
    }()
    
    private lazy var cancelButton = UIButton()
    private lazy var confirmButton = UIButton()
    
    private let alertTitle: String
    private let cancelTitle: String
    private let confirmTitle: String
    
    init(title: String = "원본 문구에 대한\n자세한 정보를 알고 싶으신가요?", cancelTitle: String = "오늘 하루 보지 않기", confirmTitle: String = "열기") {
        print(title, cancelTitle, confirmTitle)
        self.alertTitle = title
        self.cancelTitle = cancelTitle
        self.confirmTitle = confirmTitle
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView(title: alertTitle, cancelTitle: cancelTitle, confirmTitle: confirmTitle)
        configureLayout()
    }
    
    private func configureLayout() {
        view.addSubview(backgroundStackView, autoLayout: [.leading(30), .trailing(30), .centerY(0), .height(186)])
        
        let horizontalDividorView = makeDividerView()
        horizontalDividorView.autoLayout([.height(1)])
        [titleLabel, horizontalDividorView, bottomStackView].forEach {
            backgroundStackView.addArrangedSubview($0)
        }
        bottomStackView.autoLayout([.height(60)])
        
        let verticalDividorView = makeDividerView()
        verticalDividorView.autoLayout([.width(1)])
        [cancelButton, verticalDividorView, confirmButton].forEach {
            bottomStackView.addArrangedSubview($0)
        }
    }
    
    private func configureView(title: String, cancelTitle: String, confirmTitle: String) {
        view.backgroundColor = .primaryEmphasis.withAlphaComponent(0.5)
        
        titleLabel.setAttributedString(
            text: title,
            font: .pretendard(type: .Regular, size: 15),
            lineHeight: 21,
            charSpacing: -0.01
        )
        titleLabel.textAlignment = .center
        
        cancelButton = makeBottomButton(
            title: cancelTitle,
            color: .gray400,
            font: .pretendard(type: .Light, size: 14)
        )
        
        confirmButton = makeBottomButton(
            title: confirmTitle,
            color: .primaryEmphasis,
            font: .pretendard(type: .SemiBold, size: 14)
        )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bottomStackView.layer.addBorder(to: [.top], color: .gray100, width: 1)
    }
}

extension TitlePopupViewController {
    private func makeDividerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .gray100
        return view
    }
    
    private func makeBottomButton(title: String, color: UIColor, font: UIFont) -> UIButton {
        let button = UIButton()
        var config = UIButton.Configuration.plain()

        config.attributedTitle = AttributedString(title, attributes: .init([
            .font: font
        ]))
        config.titleAlignment = .center
        config.background.backgroundColor = .inversePrimaryEmphasis
        config.baseForegroundColor = color
        config.background.cornerRadius = 0
        button.configuration = config
        return button
    }
}
