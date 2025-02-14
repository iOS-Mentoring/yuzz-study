//
//  TypingCompletedViewController.swift
//  DailyTyping
//
//  Created by 조유진 on 2/14/25.
//

import UIKit

final class TypingCompletedViewController: BaseViewController {
    private let mainView = TypingCompletedView()
    private let viewModel: any ViewModelType
    var coordinator: TypingCompletedCoordinator?
    
    init(viewModel: any ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    override func bind() {
        
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.setTypingResultViewBorder()
    }
    
    override func configureNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mainView.closeButton)
    }
}
