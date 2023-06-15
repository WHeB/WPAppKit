//
//  +Notification.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/8/7.
//

import UIKit

public extension Notification {
    
    /// 键盘高度
    func keyBoardHeight() -> CGFloat {
        guard let userInfo = self.userInfo else {
            return 0.0
        }
        guard let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return 0.0
        }
        let size = value.cgRectValue.size
        return UIInterfaceOrientation.portrait.isLandscape ? size.width : size.height
    }
    
    /// 动画时长
    func animationTime() -> TimeInterval {
        guard let userInfo = self.userInfo else {
            return 0.25
        }
        guard let value = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return 0.25
        }
        return value
    }
    
    /// 动画类型
    func animationType() -> UIView.AnimationCurve {
        guard let userInfo = self.userInfo else {
            return .easeInOut
        }
        guard let value = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int else {
            return .easeInOut
        }
        return UIView.AnimationCurve(rawValue: value) ?? .easeInOut
    }
    
}
