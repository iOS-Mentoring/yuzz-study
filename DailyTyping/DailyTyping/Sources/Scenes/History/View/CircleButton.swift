//
//  CircleButton.swift
//  DailyTyping
//
//  Created by 조유진 on 2/25/25.
//

import UIKit

final class CircleButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(buttonType: CircleButtonType) {
        var configuration = UIButton.Configuration.plain()
        configuration.image = buttonType.image
        configuration.cornerStyle = .capsule
        configuration.imagePadding = 9
        configuration.background.strokeColor = UIColor.inversePrimaryEmphasis.withAlphaComponent(0.5)
        configuration.background.strokeWidth = 0.5
        self.configuration = configuration
    }
}

enum CircleButtonType {
    case download
    case share
    
    var image: UIImage {
        switch self {
        case .download: .iconInverseDownload
        case .share: .iconInverseShare
        }
    }
}
