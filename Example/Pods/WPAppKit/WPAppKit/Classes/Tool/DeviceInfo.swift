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
    
    /// Iphone4
    public static var isIphone4: Bool {
        return screenHeight == 480.000000 ? true : false
    }
    
    /// Iphone5
    public static var isIphone5: Bool {
        return screenHeight == 568.000000 ? true : false
    }
    
    /// Iphone6
    public static var isIphone6: Bool {
        return screenHeight == 667.000000 ? true : false
    }
    
    /// Iphone6Plus
    public static var isIphone6P: Bool {
        return screenHeight == 736.000000 ? true : false
    }
    
    /// IphoneX(S)
    public static var isIphoneX: Bool {
        return screenHeight == 812.000000 ? true : false
    }
    
    /// IphoneXR
    public static var isIphoneXR: Bool {
        if screenHeight == 896.000000 && UIScreen.main.scale == 2.0 {
            return true
        }
        return false
    }
    
    /// IphoneXS Max
    public static var isIphoneXS_Max: Bool {
        if screenHeight == 896.000000 &&
            UIScreen.main.scale == 3.0 {
            return true
        }
        return false
    }
    
    /// 判断是否有齐刘海
    public static var isHasSafeArea: Bool {
        if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone {
            return false
        }
        if #available(iOS 11.0, *) {
            if (kWindow?.safeAreaInsets.bottom ?? 0) > 0.0 {
                return true
            }
        }
        return false
    }
    
    /// 设备型号
    public static func modelName() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod1,1":  return "iPod Touch 1"
        case "iPod2,1":  return "iPod Touch 2"
        case "iPod3,1":  return "iPod Touch 3"
        case "iPod4,1":  return "iPod Touch 4"
        case "iPod5,1":  return "iPod Touch 5"
        case "iPod7,1":  return "iPod Touch 6"
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone 4"
        case "iPhone4,1":  return "iPhone 4s"
        case "iPhone5,1":  return "iPhone 5"
        case "iPhone5,2":  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":  return "iPhone 5s"
        case "iPhone7,2":  return "iPhone 6"
        case "iPhone7,1":  return "iPhone 6 Plus"
        case "iPhone8,1":  return "iPhone 6s"
        case "iPhone8,2":  return "iPhone 6s Plus"
        case "iPhone8,4":  return "iPhone SE"
        case "iPhone9,1", "iPhone9,3":  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":  return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4": return "iPhone 8"
        case "iPhone10,2", "iPhone10,5": return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6": return "iPhone X"
        case "iPhone11,8":  return "iPhone XR"
        case "iPhone11,2":  return "iPhone XS"
        case "iPhone11,6":  return "iPhone XS Max"
        case "iPhone12,1":  return "iPhone 11"
        case "iPhone12,3":  return "iPhone 11 Pro"
        case "iPhone12,5":  return "iPhone 11 Pro Max"
        case "iPhone12,8":  return "iPhone SE 2"
            
        case "iPad1,1": return "iPad"
        case "iPad1,2": return "iPad 3G"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":  return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":  return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":  return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
        case "iPad5,3", "iPad5,4":  return "iPad Air 2"
        case "iPad6,3", "iPad6,4":  return "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8":  return "iPad Pro 12.9"
            
        case "AppleTV2,1":  return "Apple TV 2"
        case "AppleTV3,1","AppleTV3,2":  return "Apple TV 3"
        case "AppleTV5,3":  return "Apple TV 4"
            
        case "i386", "x86_64":  return "Simulator"
            
        default:  return identifier
            
        }
    }
    
}
