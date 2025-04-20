//
//  MyPageViewController.swift
//  DailyTyping
//
//  Created by 조유진 on 4/20/25.
//

import UIKit

final class MyPageViewController: UIViewController {
    var coordinator: MyPageCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func closeButtonTapped() {
        coordinator?.removeCoordinator()
    }
}
