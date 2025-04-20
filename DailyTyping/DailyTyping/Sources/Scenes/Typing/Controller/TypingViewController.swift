//
//  TypingViewController.swift
//  DailyTyping
//
//  Created by 조유진 on 2/8/25.
//

import UIKit
import Combine

final class TypingViewController: UIViewController {
    private let mainView = TypingView()
    private let viewModel: any ViewModelType
    var coordinator: TypingCoordinator?
    private var cancellables = Set<AnyCancellable>()
    
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    
    init(viewModel: any ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadSubject.send(())
        configureNavigationItem()
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.setTextViewFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.addBorderToTypingInfoView()
    }
    
    // MARK: bind()
    private func bind() {
        guard let viewModel = viewModel as? TypingViewModel else { return }
        let input = TypingViewModel.Input(
            viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher(),
            textViewDidChanged: mainView.typingTextView.textPublisher
        )
        
        let output = viewModel.transform(input: input)
        
        output.pilsaInfo
            .receive(on: RunLoop.main)
            .sink { [weak self] pilsaInfo in
                guard let self else { return }
                mainView.setPilsaInfo(pilsaInfo)
            }
            .store(in: &cancellables)

        
        mainView.historyButton.tapPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self, let coordinator else { return }
                coordinator.showHistoryVC()
            }
            .store(in: &cancellables)
        
        mainView.typingInputAccessoryView.linkButton.tapPublisher
            .receive(on: RunLoop.main)
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
        
        let elapsedTime = output.elapsedTime
            .sink { [weak self] second in
                guard let self else { return }
                mainView.setElapsedTime(second: second)
                mainView.setProgressLayout(second: second)
            }
        
        let wpmValue = output.wpmValue
            .sink { [weak self] wpmValue in
                guard let self else { return }
                mainView.setWPMValue(wpm: wpmValue)
            }
        
        output.inputAttributedString
            .sink { [weak self] attributedString in
                guard let self else { return }
                mainView.setValidAttributedString(attributedString)
            }
            .store(in: &cancellables)

        output.playTimeFinished
            .receive(on: RunLoop.main)
            .sink { [weak self] pilsaTypingResult in
                guard let self else { return }
                elapsedTime.cancel()
                wpmValue.cancel()
                coordinator?.showTypingCompletedVC(pilsaTypingResult: pilsaTypingResult)
                mainView.setTypingTextViewIsEditable(false)
            }
            .store(in: &cancellables)
        
        CombineKeyboard.shared.visibleHeight
            .receive(on: RunLoop.main)
            .sink { [weak self] keyboardHeight in
                guard let self else { return }
                mainView.setTextViewContentInset(keyboardHeight: keyboardHeight)
                mainView.setTextViewAutoScroll()
            }
            .store(in: &cancellables)
        
        CombineKeyboard.shared.isHidden
            .receive(on: RunLoop.main)
            .sink { [weak self] isHidden in
                guard let self else { return }
                mainView.setTextViewIsHiddenInset(isHidden)
            }
            .store(in: &cancellables)
        
        mainView.typingTextView.scrollOffsetPublisher
            .sink { [weak self] offset in
                guard let self else { return }
                mainView.scrollPlaceholderTextView(offset: offset)
            }
            .store(in: &cancellables)
    }
    
    private func configureNavigationItem() {
        navigationItem.titleView = mainView.navigationTitleLabel
    }
    
    override func closeButtonTapped() {
        coordinator?.removeCoordinator()
    }
}
