//
//  MainCoordinator.swift
//  DailyTyping
//
//  Created by 조유진 on 2/11/25.
//

import UIKit

final class MainCoordinator: Coordinator {
    let navigationController: UINavigationController
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = TypingViewModel()
        let mainVC = TypingViewController(viewModel: viewModel)
        mainVC.coordinator = self
        navigationController.pushViewController(mainVC, animated: false)
    }
    
    func showHistoryVC() {
        let historyCoordinator = HistoryCoordinator(navigationController: navigationController)
        childCoordinators.append(historyCoordinator)
        historyCoordinator.parentCoordinator = self
        historyCoordinator.start()
    }
}
