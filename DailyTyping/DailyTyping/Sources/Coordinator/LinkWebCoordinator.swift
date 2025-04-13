//
//  LinkWebCoordinator.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//

import UIKit

final class LinkWebCoordinator: Coordinator {
    let navigationController: UINavigationController
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = LinkWebViewModel()
        let linkWebVC = LinkWebViewController(viewModel: viewModel)
        linkWebVC.coordinator = self
        navigationController.pushViewController(linkWebVC, animated: true)
    }
    
    func removeCoordinator() {
        navigationController.popViewController(animated: true)
        parentCoordinator?.removeChildCoordinator(child: self)
    }
}
