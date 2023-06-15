//
//  +UIApplication.swift
//  Kingfisher
//
//  Created by 王鹏 on 2019/8/7.
//

import UIKit

public extension UIApplication {
    
    enum PhoneType {
        case alert
        case sheet
    }
    
    /// 状态栏
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
    
    /// 跳转到App Store
    func pushAppStore(url: String) {
        guard let urlPath = URL(string: url) else { return }
        if UIApplication.shared.canOpenURL(urlPath) {
            UIApplication.shared.open(urlPath, options: [:], completionHandler: nil)
        }
    }
    
    /// 打电话
    func phone(_ phone: String, type: PhoneType) {
        switch type {
        case .alert:
            guard let phoneURL = URL(string: "telprompt://\(phone)") else {
                return
            }
            if UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            }
            
        case .sheet:
            guard let phoneURL = URL(string: "tel://\(phone)") else {
                return
            }
            if UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            }
            
        }
    }
    
    /// 跳转到<<设置>>界面
    func pushSystemSetting() {
        guard let urlPath = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(urlPath) {
            UIApplication.shared.open(urlPath, options: [:], completionHandler: nil)
        }
    }
    
}
