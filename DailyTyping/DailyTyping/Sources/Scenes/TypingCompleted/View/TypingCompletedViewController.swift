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
    
    deinit {
        coordinator?.removeCoordinator()
    }
     
    override func bind() {
        guard let viewModel = viewModel as? TypingCompletedViewModel else { return }
        let input = TypingCompletedViewModel.Input(
            closeButtonTapped: mainView.closeButton.tapPublisher,
            downloadImageButtonTapped: mainView.downloadImageButton.tapPublisher
        )
        
        let output = viewModel.transform(input: input)
        
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
    
    override func configureNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mainView.closeButton)
    }
}
