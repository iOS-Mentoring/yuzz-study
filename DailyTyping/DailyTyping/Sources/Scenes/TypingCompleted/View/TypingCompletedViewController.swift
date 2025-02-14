//
//  TypingCompletedViewController.swift
//  DailyTyping
//
//  Created by 조유진 on 2/14/25.
//

import UIKit

final class TypingCompletedViewController: BaseViewController {
    private let mainView = TypingCompletedView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func bind() {
        
    }
    
    override func loadView() {
        view = mainView
    }
}
