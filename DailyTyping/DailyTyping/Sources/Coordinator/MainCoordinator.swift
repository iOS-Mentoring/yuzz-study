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
        let viewModel = TypingViewModel(
            timerUseCase: TimerUseCaseImpl(
                pilsaUseCase: PilsaUseCaseImpl(
                    typingCalculator: TypingCalulatorImpl()
                )
            ),
            fetchPilsaInfoUseCase: DefaultFetchPilsaInfoUseCase(
                pilsaInfoRepository: PilsaInfoRepositoryImpl()
            )
        )
        
        let mainVC = TypingViewController(viewModel: viewModel)
        mainVC.coordinator = self
        navigationController.pushViewController(mainVC, animated: false)
    }
    
    func showTypingCompletedVC(pilsaTypingResult: PilsaTypingResult) {
        let typingCompletedCoordinator = TypingCompletedCoordinator(navigationController: navigationController, pilsaTypingResult: pilsaTypingResult)
        childCoordinators.append(typingCompletedCoordinator)
        typingCompletedCoordinator.parentCoordinator = self
        typingCompletedCoordinator.start()
    }
    
    func showHistoryVC() {
        let historyCoordinator = HistoryCoordinator(navigationController: navigationController)
        childCoordinators.append(historyCoordinator)
        historyCoordinator.parentCoordinator = self
        historyCoordinator.start()
    }
    
    func showLinkWebVC() {
        let linkWebCoordinator = LinkWebCoordinator(navigationController: navigationController)
        childCoordinators.append(linkWebCoordinator)
        linkWebCoordinator.parentCoordinator = self
        linkWebCoordinator.start()
    }
}
