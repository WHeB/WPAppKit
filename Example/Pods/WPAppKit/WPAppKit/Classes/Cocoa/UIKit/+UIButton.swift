//
//  +UIButton.swift
//  WPAppKit
//  倒计时
//  Created by 王鹏 on 2019/4/10.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

public extension UIButton {
    
    /// 文字 + 字颜色 + 字号
    convenience init(title: String,
                     txtColor: UIColor,
                     font: UIFont) {
        self.init(type: .custom)
        self.adjustsImageWhenHighlighted = false
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(txtColor, for: .normal)
    }
    
    /// 文字 + 字颜色 + 选中颜色 + 字号
    convenience init(title: String,
                     txtColor: UIColor,
                     selectedTxtColor: UIColor,
                     font: UIFont) {
        self.init(type: .custom)
        self.adjustsImageWhenHighlighted = false
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(txtColor, for: .normal)
        self.setTitleColor(selectedTxtColor, for: .selected)
    }
    
    /// 文字 + 字颜色 + 字号 + 背景色 + 圆角
    convenience init(title: String,
                     txtColor: UIColor,
                     font: UIFont,
                     bgColor: UIColor? = nil,
                     radius: CGFloat? = 0) {
        self.init(type: .custom)
        self.adjustsImageWhenHighlighted = false
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(txtColor, for: .normal)
        self.backgroundColor = bgColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius!
    }
    
    /// 默认图片 + 选中图片
    convenience init(normalImg: UIImage?,
                     selectedImg: UIImage?) {
        self.init(type: .custom)
        self.adjustsImageWhenHighlighted = false
        self.setImage(normalImg, for: .normal)
        self.setImage(selectedImg, for: .selected)
    }
    
    /// 文本 + 文本颜色 + 字号 + 图片
    convenience init(title: String,
                     txtColor: UIColor,
                     font: UIFont,
                     normalImg: UIImage? = nil) {
        self.init(type: .custom)
        self.adjustsImageWhenHighlighted = false
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(txtColor, for: .normal)
        self.setImage(normalImg, for: .normal)
    }
    
    /// 文本 + 颜色 + 选中颜色 + 字号 + 默认图片 + 选中图片
    convenience init(title: String,
                     txtColor: UIColor,
                     selectedTxtColor: UIColor,
                     font: UIFont,
                     normalImg: UIImage? = nil,
                     selectedImg: UIImage? = nil) {
        self.init(type: .custom)
        self.adjustsImageWhenHighlighted = false
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(txtColor, for: .normal)
        self.setTitleColor(selectedTxtColor, for: .selected)
        self.setImage(normalImg, for: .normal)
        self.setImage(selectedImg, for: .selected)
    }
    
    /// 设置背景颜色
    func setbackground(normalColor: UIColor,
                       selectedColor: UIColor, bounds: CGRect? = nil) {
        let btnSize = bounds?.size ?? self.bounds.size
        
        self.setBackgroundImage(UIImage.initFrom(color: normalColor, size: btnSize), for: .normal)
        self.setBackgroundImage(UIImage.initFrom(color: selectedColor, size: btnSize), for: .selected)
    }
    
}


public extension UIButton {
    
    /// 倒计时按钮 用于登录注册
    ///
    /// - Parameters:
    ///   - timeLine: 几秒后开始
    ///   - normalTitle: 默认文本
    ///   - countdownTitle: 开始计时后文本  例如："s" "s后重新开始"
    ///   - finishTitle: 完成后文本  例如："重新发送"
    func startCountdown(timeLine: Int, normalTitle: String? = nil, countdownTitle: String? = nil, finishTitle: String) {
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
    
    func startCountdownSafe(timeLine: Int, normalTitle: String? = nil, countdownTitle: String? = nil, finishTitle: String) {
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
                    self.setTitleColor(UIColor(hex: "#789A27"), for: .normal)
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
    func setImageOrientation(position: UIView.ContentMode, spacing: CGFloat) {
        let buttonW = self.bounds.size.width
        let buttonH = self.bounds.size.height
        guard let imgW: CGFloat = self.currentImage?.size.width,
            let imgH: CGFloat = self.currentImage?.size.height,
            let title: String = self.titleLabel?.text,
            let titleFont = self.titleLabel?.font else {
                print("---------异常---------")
                return
        }
        let titleSize = title.size(withAttributes: [kCTFontAttributeName as NSAttributedString.Key: titleFont])
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

