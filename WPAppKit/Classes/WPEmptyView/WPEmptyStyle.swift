//
//  WPEmptyStyle.swift
//  WPEmptyView
//
//  Created by admin on 2018/10/25.
//  Copyright © 2018年 wangpeng. All rights reserved.
//

import UIKit

/// EmptyView方位
public enum EVOrientation: Int {
    case top
    case center
    case bottom
}

/// EmptyView样式
public struct WPEmptyStyle {
    // 位置 默认居中
    public var orientation: EVOrientation = .center
    // 空页面背景色
    public var emptyBgColor: UIColor = UIColor.white
    
    // title字号 默认16号
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 16.0)
    // title颜色
    public var titleColor: UIColor = UIColor.darkGray
    
    // detail字号 默认14号
    public var detailFont: UIFont = UIFont.systemFont(ofSize: 14)
    // detail颜色
    public var detailColor: UIColor = UIColor.lightGray
    
    // button字号 默认16号
    public var buttonFont: UIFont = UIFont.systemFont(ofSize: 16)
    // button文字颜色
    public var buttonTitleColor: UIColor = UIColor.black
    // button背景色
    public var buttonBgColor: UIColor = UIColor.orange
    // button圆角
    public var buttonRadius: CGFloat = 20.0
    // button边框宽
    public var buttonBorderWidth: CGFloat = 0.0
    // button边框颜色
    public var buttonBorderColor: UIColor = UIColor.orange
    // button高度
    public var buttonHeight: CGFloat = 40.0
    
    // 距离顶部高度
    public var paddingTop: CGFloat = 50
    // 距离底部高度
    public var paddingBottom: CGFloat = 50
    
    public init() {
   
    }
}
