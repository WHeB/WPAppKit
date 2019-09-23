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
        if #available(iOS 13.0, *) {
            guard let placeholder = self.placeholder else {
                return
            }
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedStringKey.foregroundColor : color])
        }else {
            self.setValue(color, forKey: "_placeholderLabel.textColor")
        }
    }
    
    /// 设置 Placeholder 字号
    func setPlaceholder(font: UIFont) {
        if #available(iOS 13.0, *) {
            guard let placeholder = self.placeholder else {
                return
            }
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedStringKey.font : font])
        }else {
            self.setValue(font, forKey: "_placeholderLabel.font")
        }
    }
    
    /// 设置光标颜色
    func setCursor(color: UIColor) {
        self.tintColor = color
    }
}
