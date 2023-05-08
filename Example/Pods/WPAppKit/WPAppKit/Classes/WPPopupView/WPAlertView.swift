//
//  WPAlertView.swift
//  WPPopView
//
//  Created by admin on 2018/10/25.
//  Copyright © 2018年 wangpeng. All rights reserved.
//

import UIKit

open class WPAlertView: UIView {
    
    private var clickBlock: PopupClickButtonBlock?
    private var style: WPPopupStyle!
    private var titleLabel: UILabel!
    private var detailLabel: UILabel!
    private var buttonsView: UIView = UIView.init()
    private var alertViewW: CGFloat = 0.0
    private var labelW: CGFloat = 0.0
    private var titleH: CGFloat = 0.0
    private var detailH: CGFloat = 0.0
    private var buttonH: CGFloat = 0.0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    public convenience init(style: WPPopupStyle, title: String, detail: String?, buttons: [String], clickBlock: @escaping PopupClickButtonBlock) {
        self.init(frame: CGRect.zero)
        self.style = style
        self.settingSelfStyle()
        
        self.clickBlock = clickBlock
        // 文本宽
        self.labelW = self.alertViewW - 2 * padding
        // 标题
        self.loadTitle(title: title)
        // 详情
        if detail != nil && detail?.count != 0 {
            self.loadDetail(detail: detail!)
        }
        
        // buttons
        if buttons.count == 1{
            self.buttonH = buttonHeight
            self.loadOneButton(buttons: buttons)
        }else if buttons.count == 2 {
            self.buttonH = buttonHeight
            self.loadTwoButton(buttons: buttons)
        }else {
            self.buttonH = CGFloat(buttons.count) * buttonHeight
            self.loadMoreButton(buttons: buttons)
        }
        
        var totalH: CGFloat = 0.0
        if self.detailH == 0.0 {
            totalH = padding + self.titleH + space + buttonH
        }else {
            totalH = padding + self.titleH + space + self.detailH + space + buttonH
        }
        self.frame = CGRect.init(x: 0, y: 0, width: self.alertViewW, height: totalH)
        self.center = CGPoint.init(x: ScWidth / 2.0, y: ScHeight / 2.0)
    }
    
    // 设置view自身样式
    private func settingSelfStyle() {
        self.backgroundColor = self.style.popupBgColor
        self.layer.masksToBounds = true
        if self.style.cornerRadius < 0 {
            self.layer.cornerRadius = 0
        }else if self.style.cornerRadius > 10 {
            self.layer.cornerRadius = 10
        }else {
            self.layer.cornerRadius = self.style.cornerRadius
        }
        
        var widthScale: CGFloat = 0.5
        if self.style.widthScale < 0.5 {
            widthScale = 0.5
        }else if self.style.widthScale > 1.0 {
            widthScale = 1.0
        }else {
            widthScale = self.style.widthScale
        }
        self.alertViewW = ScWidth * widthScale
    }
    
    // 标题
    private func loadTitle(title: String) {
        let label = UILabel.init(frame: CGRect.init(x: padding, y: padding, width: self.labelW, height: self.titleH))
        self.addSubview(label)
        label.numberOfLines = 0
        label.textColor = self.style.titleColor
        label.font = self.style.titleFont
        label.text = title
        label.textAlignment = self.style.titleTextAlignment
        label.sizeToFit()
        self.titleH = label.frame.size.height
        label.frame = CGRect.init(x: padding, y: padding, width: self.labelW, height: self.titleH)
        self.titleLabel = label
    }
    
    // 内容
    private func loadDetail(detail: String) {
        let labelY = self.titleLabel.popup_bottomY + space
        let label = UILabel.init(frame: CGRect.init(x: 0, y: labelY, width: self.labelW, height: self.detailH))
        self.addSubview(label)
        // 文本
        let text = NSMutableAttributedString.init(string: detail)
        let pStyle = NSMutableParagraphStyle.init()
        pStyle.lineSpacing = rowSpace
        text.addAttributes([NSAttributedString.Key.paragraphStyle : pStyle], range: NSRange.init(location: 0, length: text.length))
        label.attributedText = text
        
        label.textColor = self.style.detailColor
        label.font = self.style.detailFont
        label.textAlignment = self.style.detailTextAlignment
        label.numberOfLines = 0
        label.sizeToFit()
        self.detailH = label.frame.size.height
        label.frame = CGRect.init(x: padding, y: labelY, width: self.labelW, height: self.detailH)
        self.detailLabel = label
    }
    
    // 只有一个button
    private func loadOneButton(buttons: [String]) {
        let bussonsViewY = self.detailH == 0 ? (self.titleLabel.popup_bottomY + space) : (self.detailLabel.popup_bottomY + space)
        self.buttonsView.frame = CGRect.init(x: 0, y: bussonsViewY, width: self.alertViewW, height: self.buttonH)
        self.addSubview(self.buttonsView)
        
        let line = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.alertViewW, height: lineHeight))
        line.backgroundColor = lineColor
        self.buttonsView.addSubview(line)
        
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 0, y: line.popup_bottomY, width: self.alertViewW, height: buttonHeight - lineHeight)
        button.setTitle(buttons[0], for: .normal)
        button.setTitleColor(self.style.lastBtnColor, for: .normal)
        button.titleLabel?.font = self.style.lastBtnFont
        button.setBackgroundImage(UIImage.popup_createImageWithColor(color: self.style.btnHighlightedColor), for: .highlighted)
        button.tag = 100
        button.addTarget(self, action: #selector(clickAction(button:)), for: .touchUpInside)
        self.buttonsView.addSubview(button)
    }
    
    // 有两个button
    private func loadTwoButton(buttons: [String]) {
        let bussonsViewY = self.detailH == 0 ? (self.titleLabel.popup_bottomY + space) : (self.detailLabel.popup_bottomY + space)
        self.buttonsView.frame = CGRect.init(x: 0, y: bussonsViewY, width: self.alertViewW, height: self.buttonH)
        self.addSubview(self.buttonsView)
        
        let line = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.alertViewW, height: lineHeight))
        line.backgroundColor = lineColor
        self.buttonsView.addSubview(line)
        
        let buttonW = (self.alertViewW - lineHeight) / 2
        let vLine = UILabel.init(frame: CGRect.init(x: buttonW, y: line.popup_bottomY, width: lineHeight, height: buttonHeight - lineHeight))
        vLine.backgroundColor = lineColor
        self.buttonsView.addSubview(vLine)
        
        for (index, item) in buttons.enumerated() {
            let button = UIButton.init(type: .custom)
            let butttonX = CGFloat(index) * (buttonW + lineHeight)
            button.frame = CGRect.init(x: butttonX, y: line.popup_bottomY, width: buttonW, height: buttonHeight - lineHeight)
            button.setTitle(item, for: .normal)
            if index == (buttons.count - 1) { // 最后一个
                button.setTitleColor(self.style.lastBtnColor, for: .normal)
                button.titleLabel?.font = self.style.lastBtnFont
            }else {
                button.setTitleColor(self.style.normalBtnColor, for: .normal)
                button.titleLabel?.font = self.style.lastBtnFont
            }
            button.setBackgroundImage(UIImage.popup_createImageWithColor(color: self.style.btnHighlightedColor), for: .highlighted)
            button.tag = 100 + index
            button.addTarget(self, action: #selector(clickAction(button:)), for: .touchUpInside)
            self.buttonsView.addSubview(button)
        }
    }
    
    // 多个button
    private func loadMoreButton(buttons: [String]) {
        let bussonsViewY = self.detailH == 0 ? (self.titleLabel.popup_bottomY + space) : (self.detailLabel.popup_bottomY + space)
        self.buttonsView.frame = CGRect.init(x: 0, y: bussonsViewY, width: self.alertViewW, height: self.buttonH)
        self.addSubview(self.buttonsView)
        
        for (index, item) in buttons.enumerated() {
            // 线
            let line = UILabel.init(frame: CGRect.init(x: 0, y: CGFloat(index) * buttonHeight, width: self.alertViewW, height: lineHeight))
            line.backgroundColor = lineColor
            self.buttonsView.addSubview(line)
            
            let button = UIButton.init(type: .custom)
            button.frame = CGRect.init(x: 0, y: line.popup_bottomY, width: self.alertViewW, height: buttonHeight - lineHeight)
            button.setTitle(item, for: .normal)
            if index == (buttons.count - 1) { // 最后一个
                button.setTitleColor(self.style.lastBtnColor, for: .normal)
                button.titleLabel?.font = self.style.lastBtnFont
            }else {
                button.setTitleColor(self.style.normalBtnColor, for: .normal)
                button.titleLabel?.font = self.style.lastBtnFont
            }
            button.setBackgroundImage(UIImage.popup_createImageWithColor(color: self.style.btnHighlightedColor), for: .highlighted)
            button.tag = 100 + index
            button.addTarget(self, action: #selector(clickAction(button:)), for: .touchUpInside)
            self.buttonsView.addSubview(button)
        }
    }
    
    /// 按钮选择
    @objc private func clickAction(button: UIButton) {
        self.clickBlock!((button.titleLabel?.text)!, button.tag-100)
        self.hideAlertView()
    }
    
    /// show
    public func showAlertView(style: WPPopupStyle?) {
        if style != nil { // 自定义alertView
            self.style = style
            let centerY = self.style.hasKeyboard ? (ScHeight-216.0)/2 : ScHeight/2
            self.center = CGPoint.init(x: ScWidth / 2.0, y: centerY)
        }
        guard let supView: WPPopupView = self.superview as? WPPopupView else {
            return
        }
        kWindowView.addSubview(supView)
        if self.style.touchHide {
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(hideAlertView))
            supView.effectView.addGestureRecognizer(tap)
        }
        
        switch self.style.animationOptions {
        case .none:
            self.alpha = 0.0
            UIView.animate(withDuration: 0.33) {
                if self.style.openEffect {
                    supView.effectView.effect = UIBlurEffect(style: .dark)
                }
                self.alpha = 1.0
            }
            
        case .zoom:
            self.layer.setValue(0, forKeyPath: "transform.scale")
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
                if self.style.openEffect {
                    supView.effectView.effect = UIBlurEffect(style: .dark)
                }
                self.layer.setValue(1.0, forKeyPath: "transform.scale")
            })
            
        case .smallToBig:
            self.layer.setAffineTransform(CGAffineTransform(scaleX: 0.01,y: 0.01))
            UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseIn, animations: {
                self.layer.setAffineTransform(CGAffineTransform(scaleX: 1.0,y: 1.0))
                if self.style.openEffect {
                    supView.effectView.effect = UIBlurEffect(style: .dark)
                }
            })
            
        case .topToCenter:
            self.layer.position = CGPoint.init(x: ScWidth / 2.0, y: -(self.popup_height / 2.0))
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: { [unowned self] in
                if self.style.openEffect {
                    supView.effectView.effect = UIBlurEffect(style: .dark)
                }
                let centerY = self.style.hasKeyboard ? (ScHeight-216.0)/2.0 : ScHeight/2.0
                self.layer.position = CGPoint.init(x: ScWidth / 2.0, y: centerY)
            })
            
        case .sheetBottomPop: // 无效
            supView.removeFromSuperview()
        case .sheetLeftPop:
            break
        case .sheetRightPop:
            break
        }
    }
    
    /// hide
    @objc public func hideAlertView() {
        guard let supView: WPPopupView = self.superview as? WPPopupView else {
            return
        }
        switch style.animationOptions {
        case .none:
            UIView.animate(withDuration: 0.33, animations: {
                self.alpha = 0.0
                if self.style.openEffect {
                    supView.effectView.effect = nil
                }
                supView.removeFromSuperview()
            })
            
        case .zoom:
            UIView.animate(withDuration: 0.33, animations: {
                self.alpha = 0.0
                if self.style.openEffect {
                    supView.effectView.effect = nil
                }
                supView.removeFromSuperview()
            })
            
        case .smallToBig:
            UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseIn, animations: {
                self.layer.setAffineTransform(CGAffineTransform(scaleX: 0.01,y: 0.01))
                if self.style.openEffect {
                    supView.effectView.effect = nil
                }
            }, completion: { (_) in
                supView.removeFromSuperview()
            })
            
        case .topToCenter:
            UIView.animate(withDuration: 0.35, animations: {
                if self.style.openEffect {
                    supView.effectView.effect = nil
                }
                self.layer.position = CGPoint.init(x: ScWidth / 2.0, y: ScHeight + self.popup_height )
            }, completion: { (_) in
                supView.removeFromSuperview()
            })
            
        case .sheetBottomPop:
            break
        case .sheetLeftPop:
            break
        case .sheetRightPop:
            break
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
