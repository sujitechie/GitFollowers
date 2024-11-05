//
//  GFTabBarController.swift
//  GITFollowers
//
//  Created by sujith on 04/11/24.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .systemGreen
        tabBar.backgroundColor = .secondarySystemBackground
        viewControllers = [createSearchNC(), createFavouritesNC()]
    }

    private func createSearchNC() -> UINavigationController {
        let searchVC = SearchViewController()
        searchVC.title = "search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    private func createFavouritesNC() -> UINavigationController {
        let favouritesVC = FavouritesListViewController()
        favouritesVC.title = "favourites"
        favouritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favouritesVC)
    }

   
}
