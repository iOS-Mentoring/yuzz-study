//
//  BaseViewController.swift
//  DailyTyping
//
//  Created by 조유진 on 2/8/25.
//

import UIKit
import Combine

class BaseViewController: UIViewController {
    var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        bind()
    }
    
    func bind() { }

    func configureNavigationItem() { }
}
