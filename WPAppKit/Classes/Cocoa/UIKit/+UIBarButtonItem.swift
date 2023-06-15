//
//  +UIBarButtonItem.swift
//  HBDNavigationBar
//
//  Created by 王鹏 on 2020/7/16.
//

import UIKit

public extension UIBarButtonItem {
    
    /// 间距
    static var flexibleSpace: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }
    
    /// 固定间距
    static func fixedSpace(width: CGFloat) -> UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        barButtonItem.width = width
        return barButtonItem
    }
    
    /// target-action
    func add(target: AnyObject, action: Selector) {
        self.target = target
        self.action = action
    }
    
}
