//
//  HistoryCoordinator.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//

import UIKit

final class HistoryCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var router: ViewRouter

    
    init(router: ViewRouter) {
        self.router = router
    }
    
    func start() {
        if let historyVC = router.navigationController.topViewController as? HistoryViewController {
            historyVC.coordinator = self
        }
    }
    
    func removeCoordinator() {
        router.dismiss(animated: true)
        removeChildCoordinator(self)
    }
}
