//
//  TypingViewController.swift
//  DailyTyping
//
//  Created by 조유진 on 2/8/25.
//

import UIKit

final class TypingViewController: BaseViewController {
    private let mainView = TypingView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.addBorderToTypingInfoView()
    }
    
    // MARK: bind()
    override func bind() {
        
    }
    
    override func configureNavigationItem() {
        navigationItem.titleView = mainView.navigationTitleLabel
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mainView.historyButton)
    }
}
