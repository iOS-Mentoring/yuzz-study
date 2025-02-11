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
    
    }
}
