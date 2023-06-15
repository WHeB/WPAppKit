//
//  +UIImageView.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/10.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

public extension UIImageView {
    
    /// 设置圆角
    ///
    /// - Parameters:
    ///   - bounds: 控件大小 自动布局需设置
    ///   - cornerRadius: 圆角大小
    func setCornerRadius(_ bounds: CGRect? = CGRect.zero,
                         cornerRadius: CGFloat) {
        let tempBounds = bounds == CGRect.zero ? self.bounds : bounds
        let maskPath = UIBezierPath(roundedRect: tempBounds!, cornerRadius: cornerRadius)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = tempBounds!
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    /// 加载本地Gif动画
    /// - Parameters:
    ///   - path: 文件路径
    ///   - repeatCount: 重复次数
    ///   - isDisappear: 执行完一次是否消失
    ///   - gifType: 图片的类型 gif/png
    func loadBundleGif(_ path: String,
                       repeatCount: Int? = 0,
                       isDisappear: Bool? = false,
                       gifType: String? = "gif") {
        // 1、加载gif图片，并转成Data类型
        guard let imgData = NSData(contentsOfFile: path) else {
            return
        }
        // 2、从data中读取数据：将data转成CGImageSource对象
        guard let imgSource = CGImageSourceCreateWithData(imgData, nil) else {
            return
        }
        // 3、获取在CGImageSource中图片的个数
        let imgCount = CGImageSourceGetCount(imgSource)
        // 4、遍历所有图片
        var imgs = [UIImage]()
        var totalDuration: TimeInterval = 0
        for i in 0..<imgCount {
            // 4.1、取出图片
            guard let cgimg = CGImageSourceCreateImageAtIndex(imgSource, i, nil) else { continue }
            let img = UIImage(cgImage: cgimg)
            if i == (imgCount-1) && (isDisappear ?? false) == false { // 保证执行完一次gif后不消失
                self.image = img
            }
            imgs.append(img)
            
            // 4.2、取出持续的时间
            guard let properties = CGImageSourceCopyPropertiesAtIndex(imgSource, i, nil) else { continue }
            let imageType: CFString = gifType == "gif" ? kCGImagePropertyPNGDictionary : kCGImagePropertyPNGDictionary
            guard let dict = (properties as NSDictionary)[imageType as String] as? NSDictionary else { continue }
            guard let duration = dict[kCGImagePropertyGIFDelayTime] as? NSNumber else { continue }
            totalDuration += duration.doubleValue
        }
        // 5、设置imageView的属性
        self.animationImages = imgs
        self.animationDuration = totalDuration
        self.animationRepeatCount = repeatCount ?? 0  // 执行一次，设置为0时无限执行
        // 6、开始播放
        self.startAnimating()
    }
    
}
