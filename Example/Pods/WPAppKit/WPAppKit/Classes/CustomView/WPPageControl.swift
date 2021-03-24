//
//  WPPageControl.swift
//  HBDNavigationBar
//
//  Created by 王鹏 on 2019/10/21.
//  点状控制器  待完善

import UIKit

enum PageControlType {
    case dot
    case ring
    case line
    case rectangle
}

enum PageControlStyle {
    // 圆点
    case dot(normalColor: UIColor, selectedColor: UIColor, size: CGSize)
    case line(normalColor: UIColor, selectedColor: UIColor, normalSize: CGSize, selectedSize: CGSize)
}

class WPPageControl: UIControl {
    
    public var pageNumbers: Int = 2         // 总页数
    public var currentPage: Int = 0         // 当前页
    public var space: CGFloat = 10          // 点间距
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
