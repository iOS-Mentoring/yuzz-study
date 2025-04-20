//
//  TypingCompletedCoordinator.swift
//  DailyTyping
//
//  Created by 조유진 on 2/14/25.
//

import UIKit

@MainActor
final class TypingCompletedCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var router: ViewRouter
    private var pilsaTypingResult: PilsaTypingResult
    
    init(router: ViewRouter, pilsaTypingResult: PilsaTypingResult) {
        self.router = router
        self.pilsaTypingResult = pilsaTypingResult
    }
    
    func start() {
        let viewModel = TypingCompletedViewModel(pilsaTypingResult: pilsaTypingResult)
        let typingCompletedVC = TypingCompletedViewController(viewModel: viewModel)
        typingCompletedVC.coordinator = self
        router.show(typingCompletedVC, style: .modalFullScreen, animated: false)
    }
    
    func removeCoordinator() {
        router.dismiss(animated: true)
        removeChildCoordinator(self)
    }
}
