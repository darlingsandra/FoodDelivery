//
//  AppDelegate.swift
//  FoodDelivery
//
//  Created by Александра Широкова on 14.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let deliveryNavController = AppAssembly.shared.mainView()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = deliveryNavController
        window?.makeKeyAndVisible()
        return true
    }
}

