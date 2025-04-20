//
//  TypingCoordinator.swift
//  DailyTyping
//
//  Created by 조유진 on 4/20/25.
//

import UIKit

final class TypingCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var router: ViewRouter

    
    init(router: ViewRouter) {
        self.router = router
    }
    
    func start() {
        let typingVC = TypingViewController(
            viewModel: TypingViewModel(
                timerUseCase: TimerUseCaseImpl(
                    pilsaUseCase: PilsaUseCaseImpl(
                        typingCalculator: TypingCalulatorImpl()
                    )
                ),
                fetchPilsaInfoUseCase: DefaultFetchPilsaInfoUseCase(
                    pilsaInfoRepository: PilsaInfoRepositoryImpl()
                )
            )
        )
        typingVC.coordinator = self
        typingVC.hidesBottomBarWhenPushed = true
        router.show(typingVC, style: .push, animated: true)
    }
    
    func removeCoordinator() {
        router.dismiss(animated: true)
        removeChildCoordinator(self)
    }
    
    func showTypingCompletedVC(pilsaTypingResult: PilsaTypingResult) {
        let typingCompletedCoordinator = TypingCompletedCoordinator(router: router, pilsaTypingResult: pilsaTypingResult)
        childCoordinators.append(typingCompletedCoordinator)
        typingCompletedCoordinator.start()
    }
    
    func showHistoryVC() {
        let historyCoordinator = HistoryCoordinator(router: router)
        childCoordinators.append(historyCoordinator)
        historyCoordinator.start()
    }
    
    func showLinkWebVC() {
        let linkWebCoordinator = LinkWebCoordinator(router: router)
        childCoordinators.append(linkWebCoordinator)
        linkWebCoordinator.start()
    }
}
