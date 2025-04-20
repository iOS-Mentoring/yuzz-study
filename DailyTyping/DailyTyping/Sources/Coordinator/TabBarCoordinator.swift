//
//  TabBarCoordinator.swift
//  DailyTyping
//
//  Created by 조유진 on 4/20/25.
//

import UIKit
 
final class TabBarCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []
    var router: ViewRouter

    init(router: ViewRouter) {
        self.router = router
    }

    func start() {
        let tabBarController = UITabBarController()
        configureTabBar(tabBarController)
        
        let historyNav = UINavigationController(rootViewController: HistoryViewController(viewModel: HistoryViewModel(calendarUseCase: CalendarUseCaseImpl())))
        let homeNav = UINavigationController(rootViewController: HomeViewController())
        let myPageNav = UINavigationController(rootViewController: MyPageViewController())

        let historyCoordinator = HistoryCoordinator(
            router: ViewRouter(navigationController: historyNav)
        )
        let homeCoordinator = HomeCoordinator(
            router: ViewRouter(navigationController: homeNav)
        )
        let myPageCoordinator = MyPageCoordinator(
            router: ViewRouter(navigationController: myPageNav)
        )

        childCoordinators = [homeCoordinator, homeCoordinator, myPageCoordinator]
        
        historyNav.tabBarItem = UITabBarItem(
            title: TabItem.haruStorageBox.title,
            image: TabItem.haruStorageBox.image,
            tag: 0
        )
        homeNav.tabBarItem = UITabBarItem(
            title: TabItem.home.title,
            image: TabItem.home.image,
            tag: 0
        )
        myPageNav.tabBarItem = UITabBarItem(
            title: TabItem.myPage.title,
            image: TabItem.myPage.image,
            tag: 0
        )

        historyCoordinator.start()
        homeCoordinator.start()
        myPageCoordinator.start()

        tabBarController.viewControllers = [historyNav, homeNav, myPageNav]
        tabBarController.selectedIndex = 1
        router.show(tabBarController, style: .push, animated: false)
    }
    
    
    private func configureTabBar(_ tabBarController: UITabBarController) {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .primaryEmphasis
        
        appearance.stackedLayoutAppearance.normal.iconColor = .gray500
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray500]
        
        appearance.stackedLayoutAppearance.selected.iconColor = .inversePrimaryEmphasis
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.inversePrimaryEmphasis]
        
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = appearance
    }
 }


enum TabItem {
    case haruStorageBox
    case home
    case myPage
    
    var title: String {
        switch self {
        case .haruStorageBox: return "하루보관함"
        case .home: return "홈"
        case .myPage: return "마이페이지"
        }
    }
    
    var image: UIImage {
        switch self {
        case .haruStorageBox: .mingcuteHistoryLine
        case .home: .btnHomePre
        case .myPage: .btnMyNor
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .haruStorageBox: .mingcuteHistoryLine
        case .home: .btnHomePre
        case .myPage: .btnMyNor
        }
    }
}
