//
//  Coordinator.swift
//  DailyTyping
//
//  Created by 조유진 on 2/11/25.
//

import UIKit

@MainActor
protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
}

extension Coordinator {
    func removeChildCoordinator(child: Coordinator) {
        childCoordinators.removeAll { $0 === child }
    }
}
