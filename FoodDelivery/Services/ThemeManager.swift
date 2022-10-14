//
//  ThemeManager.swift
//  FoodDelivery
//
//  Created by Александра Широкова on 14.10.2022.
//

import UIKit

struct ThemeManager {
    static func applyTheme() {
        let attributedFontNormal: UIFont = UIFont(name: "SFUIDisplay-Regular", size: 13) ?? .systemFont(ofSize: 13)
        
        let appearanceBar = UITabBar.appearance()
        appearanceBar.tintColor = UIColor.customRed
        appearanceBar.unselectedItemTintColor = UIColor.customMainGrey
        
        let appearanceBarItem = UITabBarItem.appearance(whenContainedInInstancesOf: [UINavigationController.self])
        appearanceBarItem.setTitleTextAttributes([NSAttributedString.Key.font: attributedFontNormal], for: .normal)
    }
}
