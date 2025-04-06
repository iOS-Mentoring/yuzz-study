//
//  TypingCompletedViewController.swift
//  DailyTyping
//
//  Created by 조유진 on 2/14/25.
//

import UIKit
import Combine

final class TypingCompletedViewController: UIViewController {
    private let mainView = TypingCompletedView()
    private let viewModel: any ViewModelType
    var coordinator: TypingCompletedCoordinator?
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
    
    deinit {
        coordinator?.removeCoordinator()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadSubject.send(())
        configureNavigationItem()
    }
     
    private func bind() {
        guard let viewModel = viewModel as? TypingCompletedViewModel else { return }
        let input = TypingCompletedViewModel.Input(
            viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher(),
            closeButtonTapped: mainView.closeButton.tapPublisher,
            downloadImageButtonTapped: mainView.downloadImageButton.tapPublisher
        )
        
        let output = viewModel.transform(input: input)
        
        output.pilsaTypingResult
            .sink { [weak self] pilsaTypingResult in
                guard let self else { return }
                mainView.setPilsaTypingResult(pilsaTypingResult)
            }
            .store(in: &cancellables)
        
        output.closeButtonTapped
            .sink { [weak self] _ in
                guard let self else { return }
                coordinator?.removeCoordinator()
            }
            .store(in: &cancellables)
        
        output.downloadImageButtonTapped
            .sink { [weak self] in
                guard let self else { return }
                let captureFrame = CGRect(
                    x: mainView.pilsaInfoView.frame.minX - 20,
                    y: mainView.pilsaInfoView.frame.minY - 40,
                    width: UIScreen.width,
                    height: mainView.pilsaInfoView.frame.height + 80
                )
                let image = mainView.captureView(view: mainView, frame: captureFrame)
                let vc = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                present(vc, animated: true)
            }
            .store(in: &cancellables)
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.setTypingResultViewBorder()
    }
    
    override func viewDidLayoutSubviews() {
        mainView.gradientLayer.frame = mainView.gradientView.bounds
    }

    private func configureNavigationItem() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.backgroundColor = .inversePrimaryEmphasis
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mainView.closeButton)
    }
}
