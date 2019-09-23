//
//  NSObject+Extension.swift
//  HBDNavigationBar
//
//  Created by 王鹏 on 2019/9/16.
//

import UIKit

public extension NSObject {
    
    /// 交换方法
    static func exchange(_ method1: String, _ method2: String) {
        guard let m1 = class_getInstanceMethod(self, Selector(method1)) else {
            return
        }
        guard let m2 = class_getInstanceMethod(self, Selector(method2)) else {
            return
        }
        method_exchangeImplementations(m1, m2)
    }
}
