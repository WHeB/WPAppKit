//
//  Notification+Extension.swift
//  Kingfisher
//
//  Created by 王鹏 on 2019/8/7.
//

import UIKit

public extension Notification {
    
    /// 键盘高度
    func keyBoardHeight() -> CGFloat {
        if let userInfo = self.userInfo {
            if let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let size = value.cgRectValue.size
                return UIInterfaceOrientation.portrait.isLandscape ? size.width : size.height
            }
        }
        return 0
    }
    
    /// 动画时长
    func animationTime() -> TimeInterval {
        if let userInfo = self.userInfo {
            if let value = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval {
                return value
            }
        }
        return 0.25
    }
    
    /// 动画类型
    func animationType() -> UIView.AnimationCurve {
        if let userInfo = self.userInfo {
            if let value = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? Int {
                return UIView.AnimationCurve(rawValue: value) ?? .easeInOut
            }
        }
        return .easeInOut
    }
    
}
