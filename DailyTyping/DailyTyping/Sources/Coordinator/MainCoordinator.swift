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
        let viewModel = TypingViewModel(timeProvider: TimerManager())
        let mainVC = TypingViewController(viewModel: viewModel)
        mainVC.coordinator = self
        navigationController.pushViewController(mainVC, animated: false)
    }
    
    func showTypingCompletedVC() {
    }
    
    func showHistoryVC() {
        let historyCoordinator = HistoryCoordinator(navigationController: navigationController)
        childCoordinators.append(historyCoordinator)
        historyCoordinator.parentCoordinator = self
        historyCoordinator.start()
    }
    
    func showLinkWebVC() {
        let linkWebCoordinator = LinkWebCoordinator(navigationController: navigationController)
        childCoordinators.append(linkWebCoordinator)
        linkWebCoordinator.parentCoordinator = self
        linkWebCoordinator.start()
    }
}
