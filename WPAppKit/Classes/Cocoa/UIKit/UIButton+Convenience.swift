//
//  UIButton+Convenience.swift
//  WPToolDemo
//
//  Created by 王鹏 on 2019/4/11.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

public extension UIButton {
    
    /// 文字 + 字颜色 + 字号
    public convenience init(title: String, txtColor: UIColor, font: UIFont) {
        self.init(type: .custom)
        self.adjustsImageWhenHighlighted = false
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(txtColor, for: .normal)
    }
    
    /// 文字 + 字颜色 + 选中颜色 + 字号
    public convenience init(title: String, txtColor: UIColor, selectedTxtColor: UIColor, font: UIFont) {
        self.init(type: .custom)
        self.adjustsImageWhenHighlighted = false
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(txtColor, for: .normal)
        self.setTitleColor(selectedTxtColor, for: .selected)
    }
    
    /// 文字 + 字颜色 + 字号 + 背景色 + 圆角
    public convenience init(title: String, txtColor: UIColor, font: UIFont, bgColor: UIColor, radius: CGFloat? = 0) {
        self.init(type: .custom)
        self.adjustsImageWhenHighlighted = false
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(txtColor, for: .normal)
        self.backgroundColor = bgColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius!
    }
    
    /// 默认图片 + 选中图片
    public convenience init(normalImg: UIImage, selectedImg: UIImage? = nil) {
        self.init(type: .custom)
        self.adjustsImageWhenHighlighted = false
        self.setImage(normalImg, for: .normal)
        let img = selectedImg ?? normalImg
        self.setImage(img, for: .selected)
    }
    
    /// 文本 + 文本颜色 + 字号 + 图片
    public convenience init(title: String, txtColor: UIColor, font: UIFont, normalImg: UIImage) {
        self.init(type: .custom)
        self.adjustsImageWhenHighlighted = false
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(txtColor, for: .normal)
        self.setImage(normalImg, for: .normal)
    }
    
    /// 文本 + 颜色 + 选中颜色 + 字号 + 默认图片 + 选中图片
    public convenience init(title: String, txtColor: UIColor, selectedTxtColor: UIColor, font: UIFont, normalImg: UIImage, selectedImg: UIImage? = nil) {
        self.init(type: .custom)
        self.adjustsImageWhenHighlighted = false
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(txtColor, for: .normal)
        self.setTitleColor(selectedTxtColor, for: .selected)
        self.setImage(normalImg, for: .normal)
        let img = selectedImg ?? normalImg
        self.setImage(img, for: .selected)
    }
    
    /// 设置背景颜色
    public func setbackground(normalColor: UIColor, selectedColor: UIColor) {
        self.setImage(UIImage.colorToImage(normalColor), for: .normal)
        self.setImage(UIImage.colorToImage(selectedColor), for: .selected)
        // 禁止闪烁
        self.addTarget(self, action: #selector(unFlashing(button:)), for: .allTouchEvents)
    }
    
    @objc func unFlashing(button: UIButton) {
        button.isHighlighted = false
    }
}
