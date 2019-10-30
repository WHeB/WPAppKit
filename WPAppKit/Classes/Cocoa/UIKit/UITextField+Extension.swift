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
    func setPlaceholder(color: UIColor) {
        guard let placeholder = self.placeholder else {
            return
        }
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedStringKey.foregroundColor : color])
    }
    
    /// 设置 Placeholder 字号
    func setPlaceholder(font: UIFont) {
        guard let placeholder = self.placeholder else {
            return
        }
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedStringKey.font : font])
    }
    
    /// 设置光标颜色
    func setCursor(color: UIColor) {
        self.tintColor = color
    }
}
