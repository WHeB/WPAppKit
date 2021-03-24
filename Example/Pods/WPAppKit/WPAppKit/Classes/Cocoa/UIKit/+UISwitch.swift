//
//  +UISwitch.swift
//  WPAppKit
//
//  Created by 王鹏 on 2020/7/16.
//

import UIKit

public extension UISwitch {
    
    /// 系统默认颜色的开关
    convenience init(target: AnyObject,
                     action: Selector) {
        self.init()
        self.addTarget(target, action: action, for: .valueChanged)
    }
    
    /// 自定义颜色的开关
    convenience init(onColor: UIColor,
                     offColor: UIColor,
                     thumbColor: UIColor,
                     target: AnyObject,
                     action: Selector) {
        self.init()
        self.onTintColor = onColor //设置开启状态显示的颜色
        self.tintColor = offColor //设置关闭状态的颜色
        self.thumbTintColor = thumbColor //滑块上小圆点的颜色
        self.addTarget(target, action: action, for: .valueChanged)
    }
    
    func toggle(animated: Bool? = true) {
        setOn(!isOn, animated: animated!)
    }
    
}
