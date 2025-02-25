//
//  HistoryViewController.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//

import UIKit
import Combine

final class HistoryViewController: BaseViewController {
    private let mainView = HistoryView()
    private let viewModel: any ViewModelType
    var coordinator: HistoryCoordinator?
    
    init(viewModel: any ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        coordinator?.removeCoordinator()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func bind() {
        guard let viewModel = viewModel as? HistoryViewModel else { return }
        let input = HistoryViewModel.Input(
            viewDidLoad: Just(()).eraseToAnyPublisher()
        )
    }
    
    override func configureNavigationItem() {
        navigationItem.titleView = mainView.navigationTitleLabel
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: mainView.backButton)
    }
}
