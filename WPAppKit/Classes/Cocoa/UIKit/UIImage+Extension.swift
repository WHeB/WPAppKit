//
//  UIImage+Extension.swift
//  WPToolDemo
//
//  Created by 王鹏 on 2019/4/10.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

public extension UIImage {
    
    /// 根据给定的颜色、尺寸、圆角生成对应的图片
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 大小
    ///   - radius: 圆角
    /// - Returns: 结果
    public class func colorToImage(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1), radius: Int = 0) -> UIImage{
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()!
        
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: CGFloat(radius))
        color.setFill()
        rectanglePath.fill()
        context.addPath(rectanglePath.cgPath)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 设置可伸缩图片 用于聊天框 边框等
    ///
    /// - Parameter imgName: 图片名字
    /// - Returns: 结果
    public class func setResizableImage(name: String) -> UIImage {
        var image = UIImage.init(named: name)
        let imgW: Float = Float(image!.size.width)
        let imgH: Float = Float(image!.size.height)
        let resultImgW  = lroundf(imgW / 2)
        let resultImgH = lroundf(imgH / 2)
        image = image?.stretchableImage(withLeftCapWidth: resultImgW, topCapHeight: resultImgH)
        return image!
    }
    
}
