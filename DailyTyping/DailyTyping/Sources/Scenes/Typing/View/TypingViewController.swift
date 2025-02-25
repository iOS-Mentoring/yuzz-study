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
                mainView.typingTextView.text.removeFirst()
            }
            .store(in: &cancellables)
        
        output.elapsedTime
            .sink { [weak self] second in
                guard let self else { return }
                mainView.setElapsedTime(second: second)
                mainView.setProgressLayout(second: second)
            }
            .store(in: &cancellables)
        
        output.wpmValue
            .sink { [weak self] wpmValue in
                guard let self else { return }
                mainView.setWPMValue(wpm: wpmValue)
            }
            .store(in: &cancellables)
        
        output.validateInputText
            .sink { [weak self] attributedString in
                guard let self else { return }
                mainView.setValidAttributedString(attributedString)
            }
            .store(in: &cancellables)

        output.typingFinished.merge(with: output.playTimeFinished)
            .sink { [weak self] pilsaTypingResult in
                guard let self else { return }
                coordinator?.showTypingCompletedVC(pilsaTypingResult: pilsaTypingResult)
                mainView.setTypingTextViewIsEditable(false)
            }
            .store(in: &cancellables)
        
        output.keyboardHeight
            .receive(on: RunLoop.main)
            .sink { [weak self] keyboardHeight in
                guard let self else { return }
                
                // textView의 contentInset.bottom을 키보드의 높이만큼 설정
                mainView.setTextViewContentInset(keyboardHeight: keyboardHeight)
                mainView.setTextViewAutoScroll()
            }
            .store(in: &cancellables)
        
        mainView.typingTextView.scrollOffsetPublisher
            .sink { [weak self] offset in
                guard let self else { return }
                mainView.scrollPlaceholderTextView(offset: offset)
            }
            .store(in: &cancellables)
    }
    
    override func configureNavigationItem() {
        navigationItem.titleView = mainView.navigationTitleLabel
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mainView.historyButton)
    }
}
