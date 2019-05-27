//
//  UITextView+Extension.swift
//  WPToolDemo
//
//  Created by 王鹏 on 2019/4/10.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

private var placeholderKey: Void?

public protocol TextViewable {}
extension UITextView: TextViewable {}

public extension TextViewable where Self: UITextView {
    
    /// placeholder
    public var placeholder: String? {
        set(newValue) {
            // iOS9 之后有 _placeholderLabel 属性
            guard #available(iOS 9.0, *) else { return }
            
            objc_setAssociatedObject(self, &placeholderKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            // 为了可以重置 先移除再添加
            let view = self.viewWithTag(999)
            if view is UILabel {
                view?.removeFromSuperview()
            }
            
            let label = UILabel.init()
            label.text = placeholder
            label.textColor = UIColor.lightGray
            label.sizeToFit()
            label.tag = 999
            // 需要设置字号  否则会向上漂移
            if self.font == nil {
                self.font = UIFont.systemFont(ofSize: 14)
            }
            label.font = self.font
            self.addSubview(label)
            self.setValue(label, forKey: "_placeholderLabel")
        }
        
        get {
            return objc_getAssociatedObject(self, &placeholderKey) as? String 
        }
    }
}

