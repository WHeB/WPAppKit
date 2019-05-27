//
//  UIButton+Extension.swift
//  WPToolDemo
//  倒计时
//  Created by 王鹏 on 2019/4/10.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

public extension UIButton {
    
    /// 倒计时按钮 用于登录注册
    ///
    /// - Parameters:
    ///   - timeLine: 几秒后开始
    ///   - normalTitle: 默认文本
    ///   - countdownTitle: 开始计时后文本  例如："s" "s后重新开始"
    ///   - finishTitle: 完成后文本  例如："重新发送"
    public func startCountdown(timeLine: Int, normalTitle: String? = nil, countdownTitle: String? = nil, finishTitle: String) {
        if normalTitle != nil {
            self.setTitle(normalTitle, for: .normal)
        }
        var timeCount = timeLine
        let codeTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        codeTimer.schedule(deadline: .now(), repeating: .seconds(1))
        codeTimer.setEventHandler(handler: {
            if timeCount <= 0 {
                codeTimer.cancel()
                DispatchQueue.main.async {
                    self.setTitle(finishTitle, for: .normal)
                    self.isUserInteractionEnabled = true
                }
            }else {
                let countdownString = countdownTitle == nil ? "s" : countdownTitle
                DispatchQueue.main.async {
                    let title = "\(timeCount)" + countdownString!
                    self.setTitle(title, for: .normal)
                    self.isUserInteractionEnabled = false
                }
                timeCount = timeCount - 1
            }
        })
        codeTimer.resume()
    }
    
     // 如果需要后台倒计时 将其加入 APPDelegate -> applicationDidEnterBackground 中
//    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier! = nil
//    backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: {
//    UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
//    if backgroundTaskIdentifier != UIBackgroundTaskInvalid{
//    backgroundTaskIdentifier = UIBackgroundTaskInvalid
//    }
//    })
 
}

public extension UIButton {
    
    /// button中图片文字同时存在时调整位置和间距（
    /// 注意：设置图片和button大小后调用）
    /// - Parameters:
    ///   - position: 图片相对于文字的位置 仅限 上下左右
    ///   - spacing: 图片和文字的间距
    public func setImageOrientation(position: UIView.ContentMode, spacing: CGFloat) {
        
        let buttonW = self.bounds.size.width
        let buttonH = self.bounds.size.height
        
        let imgW: CGFloat = (self.currentImage?.size.width)!
        let imgH: CGFloat = (self.currentImage?.size.height)!
        
        let title: String = (self.titleLabel?.text)!
        let titleFont = self.titleLabel?.font!
        let titleSize = title.size(withAttributes: [kCTFontAttributeName as NSAttributedString.Key: titleFont!])
        // 文本lable大小（显示不全时会比原值小）
        let normalW: CGFloat = (self.titleLabel?.bounds.size.width)!
        let normalH: CGFloat = (self.titleLabel?.bounds.size.height)!
        let titleW: CGFloat = normalW > titleSize.width ? normalW : titleSize.width
        let titleH: CGFloat = normalH > titleSize.height ? normalH : titleSize.height
        
        let spacing = spacing < 0 ? 0 : spacing
        
        if position == .left || position == .right {
            if buttonW < imgW + titleW + spacing {
                print("---------button太小---------")
                return
            }
            if position == .left {
                self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing / 2.0, bottom: 0, right: spacing / 2.0)
                self.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing / 2.0, bottom: 0, right: -spacing / 2.0)
            }else if position == .right {
                self.imageEdgeInsets = UIEdgeInsets(top: 0, left: titleW + spacing / 2, bottom: 0, right: -(titleW + spacing / 2.0));
                self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imgW + spacing / 2.0) , bottom: 0, right: imgW + spacing / 2.0);
            }
        }else if position == .top || position == .bottom {
            
            if buttonH < imgH + titleH + spacing {
                print("---------button太小---------")
                return
            }
            if position == .top {
                // 使图片和文字水平居中显示
                self.contentHorizontalAlignment = .center
                self.imageEdgeInsets = UIEdgeInsets(top: -(titleH + spacing), left: 0, bottom: 0, right: -titleW);
                self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imgW, bottom: -(imgH + spacing), right: 0);
            }else if position == .bottom {
                // 使图片和文字水平居中显示
                self.contentHorizontalAlignment = .center
                self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -(titleH + spacing / 2.0), right: -titleW);
                self.titleEdgeInsets = UIEdgeInsets(top: -(imgH + spacing / 2), left: -imgW, bottom: 0, right: 0);
            }
        }
    }
}

