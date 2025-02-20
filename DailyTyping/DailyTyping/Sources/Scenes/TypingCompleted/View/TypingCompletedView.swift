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
    
    let gradientView = UIView()
    let gradientLayer: CAGradientLayer = {
         let gradient = CAGradientLayer()
         gradient.type = .axial
         gradient.colors = [
             UIColor.white.cgColor,
             UIColor.white.withAlphaComponent(0).cgColor
         ]
         gradient.locations = [0, 1]
         gradient.startPoint = CGPoint(x: 0.5, y: 0)
         gradient.endPoint = CGPoint(x: 0.5, y: 1)
         return gradient
    }()

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: .crumpledWhitePaper)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let typingCompletedHeaderView = TypingCompletedHeaderView()
    private let typingResultView = TypingResultView()
    let pilsaInfoView = PilsaInfoView()
    let downloadImageButton: UIButton = {
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
        addSubview(backgroundImageView, autoLayout: [.topSafeArea(0), .leadingSafeArea(0), .trailingSafeArea(0), .bottom(0)])

        addSubview(gradientView, autoLayout: [.topSafeArea(0), .leadingSafeArea(0), .trailingSafeArea(0), .height(74)])

        gradientView.layer.addSublayer(gradientLayer)
        
        addSubview(typingCompletedHeaderView, autoLayout: [.topSafeArea(40), .leading(0), .trailing(0), .height(140)])
        
        addSubview(typingResultView, autoLayout: [.topNext(to: typingCompletedHeaderView, constant: 40), .leading(20), .trailing(20)])
        
        addSubview(pilsaInfoView, autoLayout: [.topNext(to: typingResultView, constant: 40), .leading(20), .trailing(20)])
        
        addSubview(downloadImageButton, autoLayout: [.leadingSafeArea(0), .trailingSafeArea(0), .bottomSafeArea(0), .height(70)])
        addSubview(bottomBlackView, autoLayout: [.leadingSafeArea(0), .trailingSafeArea(0), .bottom(0), .topNext(to: downloadImageButton, constant: 0)])
    }
    
    override func configureView() {
        super.configureView()
    }
    
    func setPilsaTypingResult(_ pilsaTypingResult: PilsaTypingResult) {
        typingResultView.setPerformance(pilsaTypingResult.pilsaPerformance)
        pilsaInfoView.setPilsaInfo(pilsaTypingResult.pilsaInfo)
    }
    
    func setTypingResultViewBorder() {
        typingResultView.layer.addBorder(to: [.top, .bottom], width: 1)
    }
    
    func captureView(view: UIView, frame: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: frame)
        return renderer.image { context in
            view.layer.render(in: context.cgContext)
        }
    }
}
