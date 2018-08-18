//
//  TabBarExtensions.swift
//  ContacsDelete
//
//  Created by hosein on 8/5/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit

extension UITabBarController {
    
    func deactiveTabBarController() {
        for tabBar in self.tabBar.items! {
            tabBar.isEnabled = false
        }
    }
    
    func activeTabBarController() {
        for tabBar in self.tabBar.items! {
            tabBar.isEnabled = true
        }
    }
    
    
}
