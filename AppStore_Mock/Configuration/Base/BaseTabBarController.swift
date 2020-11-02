//
//  BaseTabBarController.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/01.
//

import UIKit

class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {
    let todayViewController = TodayMainViewController()
    let gameViewController = GameMainViewController()
    let appViewController = AppMainViewController()
    let arcadeViewController = ArcadeMainViewController()
    let searchViewController = SearchMainViewController()
    
    let todayTabBarItem = UITabBarItem(title: "투데이", image: nil, tag: 0)
    let gameTabBarItem = UITabBarItem(title: "게임", image: nil, tag: 1)
    let appTabBarItem = UITabBarItem(title: "앱", image: nil, tag: 2)
    let arcadeTabBarItem = UITabBarItem(title: "아케이드", image: nil, tag: 3)
    let searchTabBarItem = UITabBarItem(title: "검색", image: nil, tag: 4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let todayNetworkController = UINavigationController(rootViewController: todayViewController)
        let gameNetworkController = UINavigationController(rootViewController: gameViewController)
        let appNetworkController = UINavigationController(rootViewController: appViewController)
        let arcadeNetworkController = UINavigationController(rootViewController: arcadeViewController)
        let searchNetworkController = UINavigationController(rootViewController: searchViewController)
        
        todayNetworkController.tabBarItem = todayTabBarItem
        gameNetworkController.tabBarItem = gameTabBarItem
        appNetworkController.tabBarItem = appTabBarItem
        arcadeNetworkController.tabBarItem = arcadeTabBarItem
        searchNetworkController.tabBarItem = searchTabBarItem
        
        self.viewControllers = [todayNetworkController, gameNetworkController, appNetworkController, arcadeNetworkController, searchNetworkController]
        
        self.delegate = self
        self.selectedIndex = 4
    }
}
