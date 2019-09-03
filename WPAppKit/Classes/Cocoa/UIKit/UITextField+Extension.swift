//
//  UITextField+Extension.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/15.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

public extension UITextField {
    
    /// 设置 Placeholder 颜色
    public func setPlaceholder(color: UIColor) {
        self.setValue(color, forKey: "_placeholderLabel.textColor")
    }
    
    /// 设置 Placeholder 字号
    public func setPlaceholder(font: UIFont) {
        self.setValue(font, forKey: "_placeholderLabel.font")
    }
    
    /// 设置光标颜色
    public func setCursor(color: UIColor) {
        self.tintColor = color
    }
}
