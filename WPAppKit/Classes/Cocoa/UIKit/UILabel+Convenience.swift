//
//  UILabel+Convenience.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/11.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

public extension UILabel {
    
    /// 便利构造器
    convenience init(text: String, txtColor: UIColor, font: UIFont, txtAlignment: NSTextAlignment? = .left) {
        self.init()
        numberOfLines = 0
        self.text = text
        self.textColor = txtColor
        self.font = font
        self.textAlignment = txtAlignment!
    }
    
    /// 细线
    convenience init(lineBgColor: UIColor) {
        self.init()
        self.backgroundColor = lineBgColor
    }
    
    
    
    
    
}
