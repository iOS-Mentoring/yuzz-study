//
//  HistoryCoordinator.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//

import UIKit

final class HistoryCoordinator: Coordinator {
    let navigationController: UINavigationController
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = HistoryViewModel(calendarUseCase: CalendarUseCaseImpl())
        let historyVC = HistoryViewController(viewModel: viewModel)
        historyVC.coordinator = self
        navigationController.pushViewController(historyVC, animated: true)
    }
    
    func removeCoordinator() {
        navigationController.popViewController(animated: true)
        parentCoordinator?.removeChildCoordinator(child: self)
    }
}
