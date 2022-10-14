//
//  AppAssembly.swift
//  FoodDelivery
//
//  Created by Александра Широкова on 14.10.2022.
//

import Foundation
import UIKit

protocol AppAssemblyType: AnyObject {
    func mainView() -> UINavigationController
}

protocol AppTabBarAssembly: AnyObject {
    func menuView() -> UINavigationController
    func contactView() -> UINavigationController
    func profileView() -> UINavigationController
    func orderView() -> UINavigationController
}

final class AppAssembly: AppAssemblyType {

    static let shared = AppAssembly()

    private init() {}

    func mainView() -> UINavigationController {
        let tabBarController = DeliveryViewController()
        let navController = UINavigationController(rootViewController: tabBarController)
        navController.isNavigationBarHidden = true
        
        let menuView = menuView()
        let contactView = contactView()
        let profileView = profileView()
        let orderView = orderView()
        
        tabBarController.setViewControllers([menuView, contactView, profileView, orderView], animated: true)
        
        return navController
    }
}

extension AppAssembly: AppTabBarAssembly {
        
    func menuView() -> UINavigationController {
        let menuVC = MenuViewController()
        let menuPresenter = MenuPresenter(view: menuVC)
        menuVC.presenter = menuPresenter
        
        let menuNC = UINavigationController(rootViewController: menuVC)
        menuNC.isNavigationBarHidden = true
        menuNC.tabBarItem = UITabBarItem.init(title: "Меню", image: UIImage(named: "Menu"), tag: 0)
        menuNC.tabBarItem.badgeColor = UIColor.red
        return menuNC
    }
    
    func contactView() -> UINavigationController {
        let contactVC = ContactViewController()
        let contactNC = UINavigationController(rootViewController: contactVC)
        contactNC.tabBarItem = UITabBarItem.init(title: "Контакты", image: UIImage(named: "Contact"), tag: 1)
        contactNC.tabBarItem.badgeColor = UIColor.red
        return contactNC
    }
    
    func profileView() -> UINavigationController {
        let profileVC = ProfileViewController()
        let profileNC = UINavigationController(rootViewController: profileVC)
        profileNC.tabBarItem = UITabBarItem.init(title: "Профиль", image: UIImage(named: "Union"), tag: 2)
        return profileNC
    }
    
    func orderView() -> UINavigationController {
        let orderVC = OrderViewController()
        let orderNC = UINavigationController(rootViewController: orderVC)
        orderNC.tabBarItem = UITabBarItem.init(title: "Корзина", image: UIImage(named: "Basket"), tag: 3)
        return orderNC
    }
}
