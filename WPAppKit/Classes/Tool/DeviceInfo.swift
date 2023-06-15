//
//  DeviceInfo.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/10.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import Foundation
import UIKit
import AdSupport

private let kWindow = UIApplication.shared.keyWindow
public struct DeviceInfo {
    
    /// app名称
    public static var appName: String {
        return Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
    }
    
    /// 版本信息
    public static var appVersion: String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    /// build版本
    public static var appBuild: String {
        return Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    }
    
    /// bundle id App唯一标识
    public static var bundleIdentifier: String {
        return Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
    }
    
    /// 名称
    public static var bundleName: String {
        return Bundle.main.infoDictionary!["CFBundleName"] as! String
    }
    
    /// 版本 + build
    public static var appVersionAndBuild: String {
        let version = appVersion
        let build = appBuild
        return version == build ? "v\(version)" : "v\(version)(\(build))"
    }
    
    /// 状态栏高度
    public static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    /// 导航栏高度
    public static var navigationBarHeight: CGFloat {
        return 44.0
    }
    
    /// tabbar高度
    public static var tabBarHeight: CGFloat {
        return isHasSafeArea ? 83.0 : 49.0
    }
    
    /// statusBar + navigationBar
    public static var headerBarHeight: CGFloat {
        return statusBarHeight + navigationBarHeight
    }
    
    /// 屏幕高
    public static var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    /// 屏幕宽
    public static var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    /// 屏幕高 - 状态栏
    public static var withoutStatusBar: CGFloat {
        return UIScreen.main.bounds.size.height - statusBarHeight
    }
    
    /// 屏幕高 - 状态栏 - 导航栏
    public static var withoutHeaderBar: CGFloat {
        return UIScreen.main.bounds.size.height - headerBarHeight
    }
    
    /// 屏幕高 - tabBarHeight
    public static var withoutTabbar: CGFloat {
        return UIScreen.main.bounds.size.height - tabBarHeight
    }
    
    /// 屏幕高 - 状态栏 - 导航栏 - tabBarHeight
    public static var withoutBar: CGFloat {
        return UIScreen.main.bounds.size.height - headerBarHeight - tabBarHeight
    }
    
    /// 底部安全区域高度
    public static var bottomSafeHeight: CGFloat {
        if #available(iOS 11.0, *) {
            return kWindow?.safeAreaInsets.bottom ?? 0
        }
        return 0
    }
    
    /// 判断是否有齐刘海
    public static var isHasSafeArea: Bool {
        if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone {
            return false
        }
        let window = UIApplication.shared.keyWindow
        let topInset = window?.safeAreaInsets.top ?? 0
        return topInset > 0
    }
    
}
