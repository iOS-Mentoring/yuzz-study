//
//  Router.swift
//  DailyTyping
//
//  Created by 조유진 on 4/20/25.
//

import UIKit

enum PresentationStyle {
    case push
    case modalFullScreen
    case modelSheet
    case bottomSheet
}

@MainActor
protocol ViewRoutable: AnyObject {
    func show(_ viewController: UIViewController, style: PresentationStyle, animated: Bool)
    func dismiss(animated: Bool)
}

final class ViewRouter: ViewRoutable {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func show(_ viewController: UIViewController, style: PresentationStyle, animated: Bool) {
        switch style {
        case .push:
            setupBackButton(for: viewController)
            navigationController.pushViewController(viewController, animated: animated)
        case .modalFullScreen:
            setupCloseButton(for: viewController)
            viewController.modalPresentationStyle = .fullScreen
            navigationController.present(viewController, animated: animated, completion: nil)
        case .modelSheet:
            setupCloseButton(for: viewController)
            viewController.modalPresentationStyle = .automatic
            navigationController.present(viewController, animated: animated, completion: nil)
        case .bottomSheet: break
        }
    }
    
    func dismiss(animated: Bool) {
        if navigationController.viewControllers.count > 0 {
            navigationController.popViewController(animated: animated)
        } else {
            dismiss(animated: animated)
        }
    }
    
    private func setupBackButton(for viewController: UIViewController) {
        let backButtonImage = UIImage.iconLeftArrow.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: viewController, action: #selector(viewController.closeButtonTapped))
        backButton.tintColor = .primaryEmphasis
        viewController.navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupCloseButton(for viewController: UIViewController) {
        let closeButton = UIBarButtonItem(image: .iconClose, style: .plain, target: viewController, action: #selector(viewController.closeButtonTapped))
        closeButton.tintColor = .primaryEmphasis
        viewController.navigationItem.rightBarButtonItem = closeButton
    }
}
    
