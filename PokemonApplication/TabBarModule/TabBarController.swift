//
//  TabBarController.swift
//  Pokemon Application
//
//  Created by And Nik on 26.01.23.
//

import UIKit

final class TabBarController: UITabBarController{
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.tabBarCongif()
        self.createTabBar()
    }
    
    private func tabBarCongif(){
        tabBar.tintColor = .systemGreen
    }
    
    private func createTabBar() {
        let navigationGalleryVC = UINavigationController(rootViewController: Builder.shared.createGalleryVC())
        navigationGalleryVC.tabBarItem.image = UIImage(systemName: "circle.bottomhalf.filled")
        navigationGalleryVC.tabBarItem.title = "Pokemons".localized()
        
        let navigationFavoritesVC = UINavigationController(rootViewController: Builder.shared.createFavoritesVC())
        navigationFavoritesVC.tabBarItem.image = UIImage(systemName: "star.fill")
        navigationFavoritesVC.tabBarItem.title = "Favorites".localized()
        
        self.viewControllers = [navigationGalleryVC, navigationFavoritesVC]
    }
}
