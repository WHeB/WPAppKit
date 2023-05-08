//
//  WPPopupStyle.swift
//  WPPopView
//
//  Created by admin on 2018/10/25.
//  Copyright © 2018年 wangpeng. All rights reserved.
//

import UIKit

let kWindowView: UIView = UIApplication.shared.keyWindow!
let ScWidth = UIScreen.main.bounds.size.width
let ScHeight = UIScreen.main.bounds.size.height
// button + 线 高度
let buttonHeight: CGFloat = 50.0
// 线
let lineHeight: CGFloat = 1 / UIScreen.main.scale
// 线颜色
let lineColor: UIColor = UIColor.init(popup_hex: "DBDBDB")
// 边距
let padding: CGFloat = 20.0
// 子view间距
let space: CGFloat = 18.0
// 行间距 主要是detailLabel
let rowSpace: CGFloat = 5.0

public enum AnimationOptions {
    case none // 默认
    case zoom // 先放大，再缩小，在还原;  对 sheet 无效
    case smallToBig // 从小变大; 对 sheet 无效
    case topToCenter // 从顶部到中间; 对 sheet pop 无效
    case buttomPop // 底部弹出; 对 alert 无效
}

/// BubbleView三角view指向
public enum TriangleOrientation {
    case top
    case left
    case buttom
    case right
}

public struct WPPopupStyle {
    
    /// 动画样式
    public var animationOptions: AnimationOptions = .none
    /// 是否要毛玻璃效果
    public var openEffect: Bool = false
    /// 毛玻璃的alpha
    public var effectAlpha: CGFloat = 0.4
    /// 点击背景移除
    public var touchHide: Bool = false
    /// 保护层背景颜色
    public var coverBgColor: UIColor = UIColor.black.withAlphaComponent(0.4)
    /// 背景颜色
    public var popupBgColor: UIColor = UIColor.white
    /// 是否有键盘 自定义alertView时有效
    public var hasKeyboard: Bool = false
    
    //****** 自定义view时 以下样式无效 ******//
    /// 宽度占比 (0.5~1)
    public var widthScale: CGFloat = 0.7
    /// 圆角大小 (0~10)  = 0 没有圆角
    public var cornerRadius: CGFloat = 5
    
    //****** 仅Alert和Sheet有效，Bubble无效 ******//
    /// title颜色
    public var titleColor: UIColor = UIColor.black
    /// title字号
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 16)
    /// title位置
    public var titleTextAlignment: NSTextAlignment = .center
    
    /// detail颜色
    public var detailColor: UIColor = UIColor.init(popup_hex: "333333")
    /// detail字号
    public var detailFont: UIFont = UIFont.systemFont(ofSize: 14)
    /// detail位置
    public var detailTextAlignment: NSTextAlignment = .center
    
    /// buttonTitleColor
    public var normalBtnColor: UIColor = UIColor.init(popup_hex: "333333")
    /// 最后一个button颜色 一般为主色调
    public var lastBtnColor: UIColor = UIColor.black
    /// button高亮颜色
    public var btnHighlightedColor: UIColor = UIColor.init(popup_hex: "EBEBEB")
    /// button字号
    public var normalBtnFont: UIFont = UIFont.systemFont(ofSize: 16)
    /// 最后一个button字号
    public var lastBtnFont: UIFont = UIFont.systemFont(ofSize: 16)
    
    //****** 仅Bubble有效，Alert和Sheet无效 ******//
    /// 三角指向（注意：和气泡方向相反）
    public var triangleOrientation: TriangleOrientation = .top
    /// 校准小三角位置（正负值）
    public var adjustDistance: CGFloat = 0.0
    /// 文本颜色
    public var labelColor: UIColor = UIColor.init(popup_hex: "333333")
    /// 文本字号
    public var labelFont = UIFont.systemFont(ofSize: 14)
    /// 文本位置
    public var labelAlignment: NSTextAlignment = .left
    /// 分割线颜色
    public var lineColor: UIColor = UIColor.clear
    /// 分割线起点
    public var lineSpace: (leftSpace: CGFloat, rightSpace: CGFloat) = (15, 0)
    
    public init() {}
}



