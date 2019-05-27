//
//  UIView+Extension.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/10.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

/// 方位
public enum Orientation {
    case lettTop
    case top
    case rightTop
    case right
    case rightBottom
    case bottom
    case leftBottom
    case left
}

public extension UIView {
    
    /// 裁剪view的圆角
    ///
    /// - Parameters:
    ///   - direction: 圆角位置
    ///   - cornerRadius: 圆角大小
    ///   - bounds: 控件大小 自动布局需设置
    public func setCornerRadius(_ direction: UIRectCorner, cornerRadius: CGFloat, bounds: CGRect? = CGRect.zero) {
        let tempBounds = bounds == CGRect.zero ? self.bounds : bounds
        let cornerSize = CGSize(width: cornerRadius, height: cornerRadius)
        let maskPath = UIBezierPath(roundedRect: tempBounds!, byRoundingCorners: direction, cornerRadii: cornerSize)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = tempBounds!
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    /// 裁剪view全部圆角
    ///
    /// - Parameters:
    ///   - cornerRadius: 圆角大小
    ///   - bounds: 控件大小 自动布局需设置
    public func setAllCornerRadius(cornerRadius: CGFloat, bounds: CGRect? = CGRect.zero) {
        self.setCornerRadius(.allCorners, cornerRadius: cornerRadius, bounds: bounds)
    }
    
    /// 为view设置边框
    ///
    /// - Parameters:
    ///   - color: 边框颜色
    ///   - borderWidth: 边框宽度
    public func setBorder(color: UIColor, borderWidth: CGFloat, bounds: CGRect? = CGRect.zero) {
        let tempBounds = bounds == CGRect.zero ? self.bounds : bounds
        let linePath = UIBezierPath.init(rect: tempBounds!)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = tempBounds!
        shapeLayer.path = linePath.cgPath
        shapeLayer.lineWidth = borderWidth
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(shapeLayer)
    }
    
    /// 为view添加渐变色
    ///
    /// - Parameters:
    ///   - startOrientation: 起点
    ///   - endOrientation: 终点
    ///   - colors: 渐变颜色
    public func setGradientColor(startOrientation: Orientation, endOrientation: Orientation, colors: [CGColor]) {
        let gradientColors: [CGColor] = colors
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        
        // 起点
        switch startOrientation {
        case .lettTop:
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
            break
        case .top:
            gradientLayer.startPoint = CGPoint.init(x: 0.5, y: 0)
            break
        case .rightTop:
            gradientLayer.startPoint = CGPoint.init(x: 1, y: 0)
            break
        case .right:
            gradientLayer.startPoint = CGPoint.init(x: 1, y: 0.5)
            break
        case .rightBottom:
            gradientLayer.startPoint = CGPoint.init(x: 1, y: 1)
            break
        case .bottom:
            gradientLayer.startPoint = CGPoint.init(x: 0.5, y: 1)
            break
        case .leftBottom:
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 1)
            break
        case .left:
            gradientLayer.startPoint = CGPoint.init(x: 0.5, y: 1)
            break
        }
        // 终点
        switch endOrientation {
        case .lettTop:
            gradientLayer.endPoint = CGPoint.init(x: 0, y: 0)
            break
        case .top:
            gradientLayer.endPoint = CGPoint.init(x: 0.5, y: 0)
            break
        case .rightTop:
            gradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
            break
        case .right:
            gradientLayer.endPoint = CGPoint.init(x: 1, y: 0.5)
            break
        case .rightBottom:
            gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
            break
        case .bottom:
            gradientLayer.endPoint = CGPoint.init(x: 0.5, y: 1)
            break
        case .leftBottom:
            gradientLayer.endPoint = CGPoint.init(x: 0, y: 1)
            break
        case .left:
            gradientLayer.endPoint = CGPoint.init(x: 0.5, y: 1)
            break
        }
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    /// 设置阴影
    ///
    /// - Parameters:
    ///   - color: 阴影颜色
    ///   - alpha: alpha
    ///   - range: 范围
    ///   - offset: 偏移量
    func setShadow(color: UIColor, alpha: Float? = 0.5, range: CGFloat, offset: CGSize? = CGSize.init(width: 10, height: 10)) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = alpha! //不透明度
        self.layer.shadowRadius = range //设置阴影所照射的范围
        self.layer.shadowOffset = offset! // 设置阴影的偏移量
        //  向左偏移20  （-20，0）
        //  向右偏移20   （20，0）
        //  向上偏移20   （0，-20）
        //  向下偏移20   （0，20）
    }
    
    /// 虚线边框
    ///
    /// - Parameters:
    ///   - lineColor: 虚线颜色
    ///   - lineWidth: 虚线宽
    ///   - cornerRadius: 圆角大小
    ///   - lineDash: 数组 第一个数虚线长度 第二个间距
    ///   - direction: 圆角位置
    ///   - bounds: 控件大小 自动布局需设置
    func setDashLineBorder(lineColor: UIColor, lineWidth: CGFloat, cornerRadius: CGFloat? = 0, lineDash: [NSNumber]? = [4, 2], _ direction: UIRectCorner? = .allCorners, bounds: CGRect? = CGRect.zero) {
        let cornerSize = CGSize(width: cornerRadius!, height: cornerRadius!)
        let tempBounds = bounds == CGRect.zero ? self.bounds : bounds
        let path = UIBezierPath.init(roundedRect: tempBounds!, byRoundingCorners: direction!, cornerRadii: cornerSize)
        let border = CAShapeLayer.init()
        border.strokeColor = lineColor.cgColor
        border.fillColor = nil
        border.path = path.cgPath
        border.frame = tempBounds!
        border.lineWidth = lineWidth
        border.lineCap = "square"
        border.lineDashPattern = lineDash
        self.layer.addSublayer(border)
    }
}

