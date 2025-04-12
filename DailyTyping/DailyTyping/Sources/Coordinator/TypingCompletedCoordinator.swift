//
//  TypingCompletedCoordinator.swift
//  DailyTyping
//
//  Created by 조유진 on 2/14/25.
//

import UIKit

@MainActor
final class TypingCompletedCoordinator: Coordinator {
    let navigationController: UINavigationController
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    private var pilsaTypingResult: PilsaTypingResult
    
    init(navigationController: UINavigationController, pilsaTypingResult: PilsaTypingResult) {
        self.navigationController = navigationController
        self.pilsaTypingResult = pilsaTypingResult
    }
    
    func start() {
        let viewModel = TypingCompletedViewModel(pilsaTypingResult: pilsaTypingResult)
        let typingCompletedVC = TypingCompletedViewController(viewModel: viewModel)
        typingCompletedVC.coordinator = self
        navigationController.pushViewController(typingCompletedVC, animated: false)
    }
    
    func removeCoordinator() {
        navigationController.popViewController(animated: false)
        parentCoordinator?.removeChildCoordinator(child: self)
    }
}
