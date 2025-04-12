//
//  LinkWebView.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//

import UIKit
import WebKit

final class LinkWebView: BaseView {
    let backButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.image = .iconLeftArrow.resized(to: CGSize(width: 24, height: 24))
        button.configuration = configuration
        
        return button
    }()
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.backgroundColor = .inversePrimaryEmphasis
        return webView
    }()
    
    override func configureLayout() {
        addSubview(webView, autoLayout: [.leadingSafeArea(0), .topSafeArea(0), .trailingSafeArea(0), .bottomSafeArea(0)])
    }
    
    override func configureView() {
        super.configureView()
    }
    
    func loadWebView(urlString: String = LinkWebLabelText.defaultLink.rawValue) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
