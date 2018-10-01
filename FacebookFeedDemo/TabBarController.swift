//
//  TabBarController.swift
//  FacebookFeedDemo
//
//  Created by Demo on 23.09.2018.
//  Copyright © 2018 Demo. All rights reserved.
//

import UIKit


class TabBarControler: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let feedController = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        
        let navigationController = UINavigationController(rootViewController: feedController)
        
        navigationController.title = "Haberler"
        navigationController.tabBarItem.image = UIImage(named: "news_feed_icon")
        
        let friendsViewController = FriendRequestsController()
        let friendsNavigationVC = UINavigationController(rootViewController: friendsViewController)
        friendsNavigationVC.title = "Arkadaşlar"
        friendsNavigationVC.tabBarItem.image = UIImage(named: "requests_icon")

        
        viewControllers = [navigationController, friendsNavigationVC]
        tabBar.isTranslucent = false

        
        
    }
    
}
