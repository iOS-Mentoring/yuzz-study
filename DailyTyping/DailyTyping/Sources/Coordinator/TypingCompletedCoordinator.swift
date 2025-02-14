//
//  TypingCompletedCoordinator.swift
//  DailyTyping
//
//  Created by 조유진 on 2/14/25.
//

import UIKit

final class TypingCompletedCoordinator: Coordinator {
    let navigationController: UINavigationController
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = TypingCompletedViewModel()
        let typingCompletedVC = TypingCompletedViewController(viewModel: viewModel)
        typingCompletedVC.coordinator = self
        navigationController.present(typingCompletedVC, animated: true)
    }
    
    func removeCoordinator() {
        print(#function)
        parentCoordinator?.removeChildCoordinator(child: self)
    }
}
