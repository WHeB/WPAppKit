//
//  +NSAttributedString.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/8/7.
//

import UIKit

public extension NSAttributedString {
    
    /// 设置富文本
    ///
    /// - Parameters:
    ///   - original: 原文本
    ///   - target: 需要特殊化的文本
    ///   - font: 特殊字号
    ///   - textColor: 特殊颜色
    ///   - bgColor: 特殊背景色
    /// - Returns: 被修饰过的文本
    static func setBaseAttributToString(original: String,
                                        target: String,
                                        font: UIFont? = nil,
                                        textColor: UIColor? = nil,
                                        bgColor: UIColor? = nil) -> NSMutableAttributedString {
        
        let range = (original as NSString).range(of: target)
        let nsRange = NSRange(location: range.location, length: range.length)
        let attributed = NSMutableAttributedString(string: original)
        if let font = font {
            attributed.addAttribute(NSAttributedString.Key.font, value: font, range: nsRange)
        }
        if let textColor = textColor {
            attributed.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: nsRange)
        }
        if let bgColor = bgColor {
            attributed.addAttribute(NSAttributedString.Key.backgroundColor, value: bgColor, range: nsRange)
        }
        return attributed
    }
}

public extension NSMutableAttributedString {
    
    /// 设置基础富文本
    ///
    /// - Parameters:
    ///   - font: 字号
    ///   - textColor: 字体颜色
    ///   - bgColor: 背景色
    ///   - range: 范围
    func setBaseAttributToRange(range: NSRange,
                                font: UIFont? = nil,
                                textColor: UIColor? = nil,
                                bgColor: UIColor? = nil) {
        if let font = font {
            self.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        }
        if let textColor = textColor {
            self.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: range)
        }
        if let bgColor = bgColor {
            self.addAttribute(NSAttributedString.Key.backgroundColor, value: bgColor, range: range)
        }
    }
    
}
