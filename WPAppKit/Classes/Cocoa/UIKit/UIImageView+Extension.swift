//
//  UIImageView+Extension.swift
//  WPToolDemo
//
//  Created by 王鹏 on 2019/4/10.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

public extension UIImageView {
    
    /// 设置圆角
    ///
    /// - Parameters:
    ///   - bounds: 控件大小 自动布局需设置
    ///   - cornerRadius: 圆角大小
    public func setCornerRadius(_ bounds: CGRect? = CGRect.zero, cornerRadius: CGFloat) {
        let tempBounds = bounds == CGRect.zero ? self.bounds : bounds
        let maskPath = UIBezierPath(roundedRect: tempBounds!, cornerRadius: cornerRadius)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = tempBounds!
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    
    
}
