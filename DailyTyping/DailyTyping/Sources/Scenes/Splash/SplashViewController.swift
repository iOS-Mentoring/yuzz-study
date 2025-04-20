//
//  SplashViewController.swift
//  DailyTyping
//
//  Created by 조유진 on 4/20/25.
//

import UIKit

final class SplashViewController: UIViewController {
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.setAttributedString(
            text: "하루\n필사",
            font: .nanumMyeongjo(type: .Bold, size: 50),
            lineHeight: 60,
            charSpacing: -0.03
        )
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var appCoordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showMainVC()
        }
    }
    
    private func showMainVC() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
           let sceneDelegate = windowScene.delegate as? SceneDelegate
        let nav = UINavigationController()
        let appCoordinator = AppCoordinator(navigationController: nav)
        self.appCoordinator = appCoordinator
        appCoordinator.start()
        
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    private func setupLayout() {
        view.addSubview(titleLabel, autoLayout: [.center(0)])
    }
}
