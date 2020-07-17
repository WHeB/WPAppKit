//
//  UIView+Extension.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/10.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

public extension UIView {
    /// 方位
    enum Orientation {
        case leftTop
        case top
        case rightTop
        case right
        case rightBottom
        case bottom
        case leftBottom
        case left
        case center
    }
    
    /// 裁剪view的圆角
    ///
    /// - Parameters:
    ///   - direction: 圆角位置
    ///   - cornerRadius: 圆角大小
    ///   - bounds: 控件大小 自动布局需设置
    func setCornerRadius(_ direction: UIRectCorner,
                         cornerRadius: CGFloat,
                         bounds: CGRect? = CGRect.zero) {
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
    func setAllCornerRadius(cornerRadius: CGFloat,
                            bounds: CGRect? = CGRect.zero) {
        self.setCornerRadius(.allCorners, cornerRadius: cornerRadius, bounds: bounds)
    }
    
    /// 为view设置边框
    ///
    /// - Parameters:
    ///   - color: 边框颜色
    ///   - borderWidth: 边框宽度
    func setBorder(color: UIColor,
                   borderWidth: CGFloat,
                   bounds: CGRect? = CGRect.zero) {
        let tempBounds = bounds == CGRect.zero ? self.bounds : bounds
        let linePath = UIBezierPath(rect: tempBounds!)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = tempBounds!
        shapeLayer.path = linePath.cgPath
        shapeLayer.lineWidth = borderWidth
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(shapeLayer)
    }
    
    /// 设置圆角 + 边框
    ///
    /// - Parameters:
    ///   - direction: 圆角位置
    ///   - cornerRadius: 圆角大小
    ///   - color: 边框颜色
    ///   - borderWidth: 边框宽度
    ///   - bounds: 控件大小 自动布局需设置
    func setCornerRadiusAndBorder(_ direction: UIRectCorner? = .allCorners,
                                  cornerRadius: CGFloat,
                                  color: UIColor,
                                  borderWidth: CGFloat,
                                  bounds: CGRect? = CGRect.zero) {
        
        let tempBounds = bounds == CGRect.zero ? self.bounds : bounds
        let cornerSize = CGSize(width: cornerRadius, height: cornerRadius)
        let maskPath = UIBezierPath(roundedRect: tempBounds!, byRoundingCorners: direction!, cornerRadii: cornerSize)
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = tempBounds!
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = tempBounds!
        shapeLayer.path = maskPath.cgPath
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
    func setGradientColor(startOrientation: Orientation,
                          endOrientation: Orientation,
                          colors: [CGColor],
                          bounds: CGRect? = CGRect.zero) {
        let gradientColors: [CGColor] = colors
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        
        // 起点
        switch startOrientation {
        case .leftTop:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            break
        case .top:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            break
        case .rightTop:
            gradientLayer.startPoint = CGPoint(x: 1, y: 0)
            break
        case .right:
            gradientLayer.startPoint = CGPoint(x: 1, y: 0.5)
            break
        case .rightBottom:
            gradientLayer.startPoint = CGPoint(x: 1, y: 1)
            break
        case .bottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
            break
        case .leftBottom:
            gradientLayer.startPoint = CGPoint(x: 0, y: 1)
            break
        case .left:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            break
        case .center:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
            break
        }
        // 终点
        switch endOrientation {
        case .leftTop:
            gradientLayer.endPoint = CGPoint(x: 0, y: 0)
            break
        case .top:
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
            break
        case .rightTop:
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
            break
        case .right:
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            break
        case .rightBottom:
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            break
        case .bottom:
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
            break
        case .leftBottom:
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            break
        case .left:
            gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
            break
        case .center:
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
            break
        }
        let tempBounds = bounds == CGRect.zero ? self.bounds : bounds
        gradientLayer.frame = tempBounds ?? CGRect.zero
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    /// 设置阴影
    ///
    /// - Parameters:
    ///   - color: 阴影颜色
    ///   - alpha: alpha
    ///   - range: 范围
    ///   - offset: 偏移量
    func setShadow(color: UIColor,
                   alpha: Float? = 1,
                   range: CGFloat,
                   offset: CGSize? = CGSize(width: 0, height: 0)) {
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
    func setDashLineBorder(lineColor: UIColor,
                           lineWidth: CGFloat,
                           cornerRadius: CGFloat? = 0,
                           lineDash: [NSNumber]? = [4, 2],
                           direction: UIRectCorner? = .allCorners,
                           bounds: CGRect? = CGRect.zero) {
        let cornerSize = CGSize(width: cornerRadius!, height: cornerRadius!)
        let tempBounds = bounds == CGRect.zero ? self.bounds : bounds
        let path = UIBezierPath(roundedRect: tempBounds!, byRoundingCorners: direction!, cornerRadii: cornerSize)
        let border = CAShapeLayer()
        border.strokeColor = lineColor.cgColor
        border.fillColor = nil
        border.path = path.cgPath
        border.frame = tempBounds!
        border.lineWidth = lineWidth
        border.lineCap = CAShapeLayerLineCap(rawValue: "square")
        border.lineDashPattern = lineDash
        self.layer.addSublayer(border)
    }
    
    /// 使模糊视图
    func blur(withStyle style: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
        clipsToBounds = true
    }
    
    
    
}

public extension UIView {
    
    /// 将当前视图转为UIImage
    // 将转换后的UIImage保存到相机胶卷中
    // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    func asImage() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    /// 屏幕快照
    var screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
}


public extension UIView {
    
    /// 添加子view
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
    
    /// 移除所有子view
    func removeSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }
    
    /// 添加手势
    func addGestureRecognizers(_ gestureRecognizers: [UIGestureRecognizer]) {
        for recognizer in gestureRecognizers {
            addGestureRecognizer(recognizer)
        }
    }
    
    /// 移除手势
    func removeGestureRecognizers() {
        gestureRecognizers?.forEach(removeGestureRecognizer)
    }
    func removeGestureRecognizers(_ gestureRecognizers: [UIGestureRecognizer]) {
        for recognizer in gestureRecognizers {
            removeGestureRecognizer(recognizer)
        }
    }
    
    /// 添加轻拍手势
    func addTapGesture(tapNumber: Int? = 1,
                       target: AnyObject,
                       action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber!
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    
    /// 添加轻扫手势
    func addSwipeGesture(direction: UISwipeGestureRecognizer.Direction,
                         numberOfTouches: Int? = 2,
                         target: AnyObject, action: Selector) {
        let swipe = UISwipeGestureRecognizer(target: target, action: action)
        swipe.direction = direction
        swipe.numberOfTouchesRequired = numberOfTouches!
        addGestureRecognizer(swipe)
        isUserInteractionEnabled = true
    }
    
    /// 添加平移手势
    func addPanGesture(target: AnyObject,
                       action: Selector) {
        let pan = UIPanGestureRecognizer(target: target, action: action)
        addGestureRecognizer(pan)
        isUserInteractionEnabled = true
    }
    
    /// 添加捏合（缩放）手势
    func addPinchGesture(target: AnyObject,
                         action: Selector) {
        let pinch = UIPinchGestureRecognizer(target: target, action: action)
        addGestureRecognizer(pinch)
        isUserInteractionEnabled = true
    }
    
    /// 添加长按手势
    func addLongPressGesture(minDuration: Double,
                             target: AnyObject,
                             action: Selector) {
        let longPress = UILongPressGestureRecognizer(target: target, action: action)
        longPress.minimumPressDuration = minDuration
        addGestureRecognizer(longPress)
        isUserInteractionEnabled = true
    }
}


public extension UIView {
    
    enum AngleUnit {
        /// 角度
        case degrees
        /// 弧度
        case radians
    }
    
    enum ShakeDirection {
        /// 水平
        case horizontal
        /// 垂直
        case vertical
    }
    
    enum ShakeAnimationType {
        case linear
        
        case easeIn
        
        case easeOut
        
        case easeInOut
    }
    
    /// 在相对轴上以角度旋转视图
    func rotate(byAngle angle: CGFloat,
                ofType type: AngleUnit,
                animated: Bool = false,
                duration: TimeInterval = 1,
                completion: ((Bool) -> Void)? = nil) {
        let angleWithType = (type == .degrees) ? .pi * angle / 180.0 : angle
        let aDuration = animated ? duration : 0
        UIView.animate(withDuration: aDuration, delay: 0, options: .curveLinear, animations: { () -> Void in
            self.transform = self.transform.rotated(by: angleWithType)
        }, completion: completion)
    }
    
    /// 将视图旋转到固定轴上的角度
    func rotate(toAngle angle: CGFloat,
                ofType type: AngleUnit,
                animated: Bool = false,
                duration: TimeInterval = 1,
                completion: ((Bool) -> Void)? = nil) {
        let angleWithType = (type == .degrees) ? .pi * angle / 180.0 : angle
        let aDuration = animated ? duration : 0
        UIView.animate(withDuration: aDuration, animations: {
            self.transform = self.transform.concatenating(CGAffineTransform(rotationAngle: angleWithType))
        }, completion: completion)
    }
    
    /// 按偏移量缩放视图
    func scale(by offset: CGPoint,
               animated: Bool = false,
               duration: TimeInterval = 1,
               completion: ((Bool) -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
                self.transform = self.transform.scaledBy(x: offset.x, y: offset.y)
            }, completion: completion)
        } else {
            transform = transform.scaledBy(x: offset.x, y: offset.y)
            completion?(true)
        }
    }
    
    func shake(direction: ShakeDirection = .horizontal,
               duration: TimeInterval = 1,
               animationType: ShakeAnimationType = .easeOut,
               completion:(() -> Void)? = nil) {
        CATransaction.begin()
        let animation: CAKeyframeAnimation
        switch direction {
        case .horizontal:
            animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        case .vertical:
            animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        }
        switch animationType {
        case .linear:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        case .easeIn:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        case .easeOut:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        case .easeInOut:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        }
        CATransaction.setCompletionBlock(completion)
        animation.duration = duration
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
        CATransaction.commit()
    }
    
}
