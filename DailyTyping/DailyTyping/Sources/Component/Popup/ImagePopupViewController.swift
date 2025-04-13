//
//  ImagePopupViewController.swift
//  DailyTyping
//
//  Created by 조유진 on 4/13/25.
//

import UIKit

final class ImagePopupViewController: UIViewController {
    private let backgroundStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .white
        stackView.clipsToBounds = true
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray200
        return imageView
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .inversePrimaryEmphasis
        return view
    }()
    
    
    private lazy var cancelButton = UIButton()
    private lazy var confirmButton = UIButton()
    
    private let image: UIImage
    private let cancelTitle: String
    private let confirmTitle: String
    
    init(image: UIImage, cancelTitle: String = "오늘 하루 보지 않기", confirmTitle: String = "닫기") {
        self.image = image
        self.cancelTitle = cancelTitle
        self.confirmTitle = confirmTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureLayout()
    }
    
    private func configureLayout() {
        view.addSubview(backgroundStackView, autoLayout: [.leading(30), .trailing(30), .centerY(0)])
        [imageView, bottomView].forEach {
            backgroundStackView.addArrangedSubview($0)
        }
        
        bottomView.autoLayout([.height(60)])
        bottomView.addSubview(cancelButton, autoLayout: [.leading(0), .top(0), .bottom(0)])
        bottomView.addSubview(confirmButton, autoLayout: [.trailing(0), .top(0), .bottom(0)])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let imageRatio = image.size.height / image.size.width
        print(imageRatio)
        imageView.autoLayout([.height(backgroundStackView.frame.width * imageRatio)])
    }
    
    private func configureView() {
        view.backgroundColor = .primaryEmphasis.withAlphaComponent(0.5)
        imageView.image = image
        
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
}

extension ImagePopupViewController {
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
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30)
        button.configuration = config
        return button
    }
}
