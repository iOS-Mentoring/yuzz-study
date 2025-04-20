//
//  HomeCoordinator.swift
//  DailyTyping
//
//  Created by 조유진 on 4/20/25.
//

import UIKit

final class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var router: ViewRouter

    
    init(router: ViewRouter) {
        self.router = router
    }
    
    func start() {
        if let homeVC = router.navigationController.topViewController as? HomeViewController {
            homeVC.coordinator = self
        }
    }
    
    func removeCoordinator() {
        router.dismiss(animated: true)
        removeChildCoordinator(self)
    }
    
    func showTypingVC() {
        let typingCoordinator = TypingCoordinator(router: router)
        childCoordinators.append(typingCoordinator)
        typingCoordinator.start()
        
    }
}
