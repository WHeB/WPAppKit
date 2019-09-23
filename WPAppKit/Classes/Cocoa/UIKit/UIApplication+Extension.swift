//
//  UIApplication+Extension.swift
//  Kingfisher
//
//  Created by 王鹏 on 2019/8/7.
//

import UIKit

public extension UIApplication {
    
    /// 状态栏
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
    
}
