//
//  LinkWebViewController.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//

import UIKit
import Combine

class LinkWebViewController: UIViewController {
    private let mainView = LinkWebView()
    private let viewModel: any ViewModelType
    var coordinator: LinkWebCoordinator?
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: any ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        bind()
    }
    
    override func loadView() {
        view = mainView
    }

    private func bind() {
        guard let viewModel = viewModel as? LinkWebViewModel else { return }
        let input = LinkWebViewModel.Input(viewDidLoadTrigger: Just(()).eraseToAnyPublisher())
        
        let output = viewModel.transform(input: input)
        
        output.viewDidLoad.sink { [weak self] _ in
            guard let self else { return }
            mainView.loadWebView()
        }
        .store(in: &cancellables)
        
        mainView.backButton.tapPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self else { return }
                coordinator?.removeCoordinator()
            }
            .store(in: &cancellables)
    }
    
    private func configureNavigation() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: mainView.backButton)
    }
}
