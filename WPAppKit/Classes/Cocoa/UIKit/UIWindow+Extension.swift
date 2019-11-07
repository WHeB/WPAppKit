//
//  UIWindow+Extension.swift
//  HBDNavigationBar
//
//  Created by 王鹏 on 2019/11/7.
//

import UIKit

public extension UIWindow {
    
    convenience init(viewController: UIViewController, backgroundColor: UIColor) {
        self.init(frame: UIScreen.main.bounds)
        self.rootViewController = viewController
        self.backgroundColor = backgroundColor
        self.makeKeyAndVisible()
    }
    
}
