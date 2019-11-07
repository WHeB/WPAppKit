//
//  UIImage+Extension.swift
//  WPAppKit
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
    class func colorToImage(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1), radius: Int = 0) -> UIImage{
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
    class func setResizableImage(name: String) -> UIImage {
        var image = UIImage.init(named: name)
        let imgW: Float = Float(image!.size.width)
        let imgH: Float = Float(image!.size.height)
        let resultImgW  = lroundf(imgW / 2)
        let resultImgH = lroundf(imgH / 2)
        image = image?.stretchableImage(withLeftCapWidth: resultImgW, topCapHeight: resultImgH)
        return image!
    }
    
    /// 将图片裁剪成指定比例（多余部分自动删除）
    func clip(ratio: CGFloat) -> UIImage {
        //计算最终尺寸
        var newSize:CGSize!
        if size.width/size.height > ratio {
            newSize = CGSize(width: size.height * ratio, height: size.height)
        }else{
            newSize = CGSize(width: size.width, height: size.width / ratio)
        }
     
        ////图片绘制区域
        var rect = CGRect.zero
        rect.size.width  = size.width
        rect.size.height = size.height
        rect.origin.x    = (newSize.width - size.width ) / 2.0
        rect.origin.y    = (newSize.height - size.height ) / 2.0
         
        //绘制并获取最终图片
        UIGraphicsBeginImageContext(newSize)
        draw(in: rect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
         
        return scaledImage!
    }
    
    /// 将图片缩放成指定尺寸（多余部分自动删除）
    func clip(to newSize: CGSize) -> UIImage {
        //计算比例
        let aspectWidth  = newSize.width/size.width
        let aspectHeight = newSize.height/size.height
        let aspectRatio = max(aspectWidth, aspectHeight)
         
        //图片绘制区域
        var scaledImageRect = CGRect.zero
        scaledImageRect.size.width  = size.width * aspectRatio
        scaledImageRect.size.height = size.height * aspectRatio
        scaledImageRect.origin.x    = (newSize.width - size.width * aspectRatio) / 2.0
        scaledImageRect.origin.y    = (newSize.height - size.height * aspectRatio) / 2.0
         
        //绘制并获取最终图片
        UIGraphicsBeginImageContext(newSize)
        draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
         
        return scaledImage!
    }
    
    
}
