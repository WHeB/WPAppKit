//
//  UIView+Empty.swift
//  WPEmptyView
//
//  Created by admin on 2018/10/25.
//  Copyright © 2018年 wangpeng. All rights reserved.
//

import UIKit

private var emptyViewKey: Void?
private var showKey: Void?

public protocol Emptyable {}

extension UIView: Emptyable {}

extension Emptyable where Self: UIView {
    
    /// 设置空view
    public var emptyView: WPEmptyView? {
        set {
            objc_setAssociatedObject(self, &emptyViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.addSubview(emptyView ?? UIView.init())
            self.bringSubview(toFront: emptyView!)
            emptyView!.isHidden = true
            emptyView?.loadSubviews()
        }
        get {
            return objc_getAssociatedObject(self, &emptyViewKey) as? WPEmptyView
        }
    }
    
    /// 是否显示
    public var showEmptyView: Bool? {
        set {
            objc_setAssociatedObject(self, &showKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.emptyView?.isHidden = !showEmptyView!
        }

        get {
            return objc_getAssociatedObject(self, &showKey) as? Bool
        }
    }
}
