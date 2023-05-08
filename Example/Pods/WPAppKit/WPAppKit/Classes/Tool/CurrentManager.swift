//
//  CurrentManager.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/10.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

public class CurrentManager: NSObject {
    
    /// 获取当前viewController
    public static func getTopController() -> UIViewController? {
        let viewController = self.getTopWindow()?.rootViewController
        return self.topViewControllerWithRootViewController(viewController: viewController)
    }
    
    /// 获取当前window
    public static func getTopWindow() -> UIWindow? {
        // 只有一个window时
        var window: UIWindow? = UIApplication.shared.keyWindow
        // 有多个window时
        if window?.windowLevel != UIWindow.Level.normal {
            // windowLevel = UIWindowLevelNormal 时，表示这个window是当前屏幕正在显示的window
            window = UIApplication.shared.windows.filter {
                $0.windowLevel == UIWindow.Level.normal
            }.first
        }
        return window
    }
    
    // 根据响应链递归获取
    private static func topViewControllerWithRootViewController(viewController: UIViewController?) -> UIViewController? {
        guard let vc = viewController else { return nil }
        if vc.presentedViewController != nil {
            return self.topViewControllerWithRootViewController(viewController: viewController?.presentedViewController!)
        }else if vc.isKind(of: UITabBarController.self) == true {
            return self.topViewControllerWithRootViewController(viewController: (viewController as! UITabBarController).selectedViewController)
        }else if vc.isKind(of: UINavigationController.self) == true {
            return self.topViewControllerWithRootViewController(viewController: (viewController as! UINavigationController).visibleViewController)
        }else {
            return vc
        }
    }
    
}
