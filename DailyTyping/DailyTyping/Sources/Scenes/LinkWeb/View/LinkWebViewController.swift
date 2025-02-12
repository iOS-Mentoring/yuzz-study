//
//  LinkWebViewController.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//

import UIKit

class LinkWebViewController: BaseViewController {
    private let mainView = LinkWebView()
    private let viewModel: any ViewModelType
    var coordinator: LinkWebCoordinator?
    
    init(viewModel: any ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func bind() {
        
    }
}
