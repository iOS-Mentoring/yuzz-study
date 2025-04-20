//
//  AppCoordinator.swift
//  DailyTyping
//
//  Created by 조유진 on 2/11/25.
//

import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var router: ViewRouter

    
    init() {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        self.router = ViewRouter(navigationController: navigationController)
    }
    
    func start() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        let sceneDelegate = windowScene.delegate as? SceneDelegate
        
        let mainCoordinator = TabBarCoordinator(router: router)
        childCoordinators.append(mainCoordinator)
        mainCoordinator.start()
        
        sceneDelegate?.window?.rootViewController = router.navigationController
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
