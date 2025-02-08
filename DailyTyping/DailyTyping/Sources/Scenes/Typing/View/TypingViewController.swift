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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.setTextViewFirstResponder()
    }

    override func loadView() {
        view = mainView
    }
    
}
