//
//  WPPopupToll.swift
//  WPPopView
//
//  Created by admin on 2018/10/26.
//  Copyright © 2018年 wangpeng. All rights reserved.
//

import UIKit

//-------------- popup_ 是防止冲冲突处理 --------------//
public struct WPPopupToll {
    
    /// 判断是否有齐刘海
    public static var popup_isHasSafeArea: Bool {
        if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone {
            return false
        }
        if #available(iOS 11.0, *) {
            let kWindow = UIApplication.shared.windows[0]
            if (kWindow.safeAreaInsets.bottom) > 0.0 {
                return true
            }
        }
        return false
    }
}

extension UIView {
    
    /// x值
    public var popup_x: CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
    }
    
    /// y值
    public var popup_y: CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }
    }
    
    /// 右边界的x值
    public var popup_rightX: CGFloat{
        get{
            return self.popup_x + self.popup_width
        }
        set{
            var r = self.frame
            r.origin.x = newValue - frame.size.width
            self.frame = r
        }
    }
    
    /// 下边界的y值
    public var popup_bottomY: CGFloat{
        get{
            return self.popup_y + self.popup_height
        }
        set{
            var r = self.frame
            r.origin.y = newValue - frame.size.height
            self.frame = r
        }
    }
    
    /// 中心x值
    public var popup_centerX : CGFloat{
        get{
            return self.center.x
        }
        set{
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    /// 中心y值
    public var popup_centerY : CGFloat{
        get{
            return self.center.y
        }
        set{
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
    /// 宽度
    public var popup_width: CGFloat{
        get{
            return self.frame.size.width
        }
        set{
            var r = self.frame
            r.size.width = newValue
            self.frame = r
        }
    }
    
    /// 高度
    public var popup_height: CGFloat{
        get{
            return self.frame.size.height
        }
        set{
            var r = self.frame
            r.size.height = newValue
            self.frame = r
        }
    }
    
    /// 起点
    public var popup_origin: CGPoint{
        get{
            return self.frame.origin
        }
        set{
            self.popup_x = newValue.x
            self.popup_y = newValue.y
        }
    }
    
    /// 大小
    public var popup_size: CGSize{
        get{
            return self.frame.size
        }
        set{
            self.popup_width = newValue.width
            self.popup_height = newValue.height
        }
    }
}

public extension UIColor {
    
    ///  设置RGB颜色
    private convenience init(popup_red: CGFloat, popup_green: CGFloat, popup_blue: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: popup_red / 255.0, green: popup_green / 255.0, blue: popup_blue / 255.0, alpha: alpha)
    }
    
    ///  设置十六进制颜色
    convenience init(popup_hex: String, alpha: CGFloat = 1.0) {
        guard popup_hex.count >= 6 else {
            self.init(popup_red: CGFloat(255), popup_green: CGFloat(255), popup_blue: CGFloat(255), alpha: alpha)
            return
        }
        var tempHex = popup_hex.uppercased()
        if tempHex.hasPrefix("0x") || tempHex.hasPrefix("##") {
            tempHex = (tempHex as NSString).substring(from: 2)
        }
        if tempHex.hasPrefix("#") {
            tempHex = (tempHex as NSString).substring(from: 1)
        }
        
        var range = NSRange(location: 0, length: 2)
        let rHex = (tempHex as NSString).substring(with: range)
        range.location = 2
        let gHex = (tempHex as NSString).substring(with: range)
        range.location = 4
        let bHex = (tempHex as NSString).substring(with: range)
        
        var r : UInt32 = 0, g : UInt32 = 0, b : UInt32 = 0
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)
        
        self.init(popup_red: CGFloat(r), popup_green: CGFloat(g), popup_blue: CGFloat(b), alpha: alpha)
    }
}


extension String {
    
    // 获取文本高
    public func  popup_getTxtHeight(txtFont: UIFont, maxWidth: CGFloat) -> CGFloat {
        let size = CGSize.init(width: maxWidth, height: 100000)
        let stringSize = (self as NSString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : txtFont], context: nil)
        return stringSize.height
    }
    // 获取文本宽
    public func  popup_getTxtWidth(txtFont: UIFont, maxHeight: CGFloat) -> CGFloat {
        let size = CGSize.init(width: 100000, height: maxHeight)
        let stringSize = (self as NSString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : txtFont], context: nil)
        return stringSize.width
    }
}

extension UIImage {
    
    /// 根据颜色生成图片
    class func popup_createImageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        color.setFill()
        UIRectFill(rect)
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage!
    }
}
