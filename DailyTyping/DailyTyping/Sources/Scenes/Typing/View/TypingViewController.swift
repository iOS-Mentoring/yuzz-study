//
//  TypingViewController.swift
//  DailyTyping
//
//  Created by 조유진 on 2/8/25.
//

import UIKit

final class TypingViewController: BaseViewController {
    private let mainView = TypingView()
    private let viewModel: any ViewModelType
    var coordinator: MainCoordinator?
    
    init(viewModel: any ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.addBorderToTypingInfoView()
        mainView.setTextViewFirstResponder()
    }
    
    // MARK: bind()
    override func bind() {
        guard let viewModel = viewModel as? TypingViewModel else { return }
        let input = TypingViewModel.Input(
            historyButtonTapped: mainView.historyButton.tapPublisher,
            linkButtonTapped: mainView.typingInputAccessoryView.linkButton.tapPublisher,
            textViewDidChanged: mainView.typingTextView.textPublisher
        )
        
        let output = viewModel.transform(input: input)
        
        output.historyButtonTapped
            .sink { [weak self] _ in
                guard let self, let coordinator else { return }
                coordinator.showHistoryVC()
            }
            .store(in: &cancellables)
        
        output.linkButtonTapped
            .sink { [weak self] in
                guard let self, let coordinator else { return }
                coordinator.showLinkWebVC()
            }
            .store(in: &cancellables)
        
        output.typingStarted
            .sink { [weak self] _ in
                guard let self else { return }
                mainView.startProgressView()
            }
            .store(in: &cancellables)
        
        output.elapsedTime
            .sink { [weak self] second in
                guard let self else { return }
                mainView.setElapsedTime(second: second)
                mainView.setProgressLayout(second: second)
            }
            .store(in: &cancellables)
    }
    
    override func configureNavigationItem() {
        navigationItem.titleView = mainView.navigationTitleLabel
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mainView.historyButton)
    }
}
