//
//  MyPageCoordinator.swift
//  DailyTyping
//
//  Created by 조유진 on 4/20/25.
//

import UIKit

final class MyPageCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var router: ViewRouter

    
    init(router: ViewRouter) {
        self.router = router
    }
    
    func start() {
        if let myPageVC = router.navigationController.topViewController as? MyPageViewController {
            myPageVC.coordinator = self
        }
    }
    
    func removeCoordinator() {
        router.dismiss(animated: true)
        removeChildCoordinator(self)
    }
}
