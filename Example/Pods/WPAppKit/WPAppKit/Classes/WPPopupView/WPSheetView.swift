//
//  WPSheetView.swift
//  WPPopView
//
//  Created by admin on 2018/10/25.
//  Copyright © 2018年 wangpeng. All rights reserved.
//

import UIKit

open class WPSheetView: UIView {
    
    private var clickBlock: PopupClickButtonBlock?
    private var style: WPPopupStyle!
    private var titleLabel: UILabel!
    private var detailLabel: UILabel!
    private var contentView: UIView = UIView.init()
    private var buttonsView: UIView = UIView.init()
    private var sheetViewW: CGFloat = 0.0
    private var labelW: CGFloat = 0.0
    private var titleH: CGFloat = 0.0
    private var detailH: CGFloat = 0.0
    private var buttonH: CGFloat = 0.0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public convenience init(style: WPPopupStyle, title: String?, detail: String?, buttons: [String], clickBlock: @escaping PopupClickButtonBlock) {
        self.init(frame: CGRect.zero)
        
        self.backgroundColor = UIColor.clear
        self.addSubview(self.contentView)
        self.addSubview(self.buttonsView)
        
        self.style = style
        self.clickBlock = clickBlock
        self.contentView.backgroundColor = style.popupBgColor
        
        self.sheetViewW = ScWidth * 1.0
        // 文本宽
        self.labelW = self.sheetViewW - 2 * padding
        // 标题
        if title != nil && title?.count != 0 {
            self.loadTitle(title: title!)
        }
        // 详情
        if detail != nil && detail?.count != 0 {
            self.loadDetail(detail: detail!)
        }
        // buttons
        if WPPopupToll.popup_isHasSafeArea {
            self.buttonH = CGFloat(buttons.count) * buttonHeight + 20 + 5
            let safetyView = UIView.init(frame: CGRect.init(x: 0, y: self.buttonH - 20, width: self.sheetViewW, height: 20))
            safetyView.backgroundColor = self.style.popupBgColor
            self.buttonsView.addSubview(safetyView)
        }else {
            self.buttonH = CGFloat(buttons.count) * buttonHeight + 5
        }
        
        var totalH: CGFloat = 0.0
        if self.titleH == 0.0 && self.detailH == 0.0 {
            totalH = style.cornerRadius + buttonH
        }else if self.titleH != 0.0 && self.detailH == 0.0 {
            self.contentView.frame = CGRect.init(x: 0, y: self.style.cornerRadius, width: self.sheetViewW, height: padding + self.titleH + space)
        }else if self.titleH == 0.0 && self.detailH != 0.0 {
            self.contentView.frame = CGRect.init(x: 0, y: self.style.cornerRadius, width: self.sheetViewW, height: padding + self.detailH + space)
        }else {
            self.contentView.frame = CGRect.init(x: 0, y: self.style.cornerRadius, width: self.sheetViewW, height: padding + self.titleH + space + self.detailH + space)
        }
        
        self.loadButtons(buttons: buttons)
        totalH = style.cornerRadius + self.contentView.bounds.size.height + buttonH
        self.frame = CGRect.init(x: 0, y: 0, width: self.sheetViewW, height: totalH)
        self.center = CGPoint.init(x: ScWidth / 2.0, y: ScHeight - totalH / 2.0)
    
        if self.style.cornerRadius > 0 {
            self .addCornerRadii(CGSize(width: self.style.cornerRadius, height: self.style.cornerRadius), bounds: CGRect(x: 0, y: 0, width: self.popup_width, height: totalH))
        }
    }
    
    // 标题
    private func loadTitle(title: String) {
        let label = UILabel.init(frame: CGRect.init(x: padding, y: padding, width: self.labelW, height: self.titleH))
        self.contentView.addSubview(label)
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
        let labelY = self.titleH == 0.0 ? padding : self.titleLabel.popup_bottomY + space
        let label = UILabel.init(frame: CGRect.init(x: 0, y: labelY, width: self.labelW, height: self.detailH))
        self.contentView.addSubview(label)
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
    
    // 多个button
    private func loadButtons(buttons: [String]) {
        var bussonsViewY: CGFloat = self.contentView.popup_bottomY
        var buttonOneY: CGFloat = lineHeight
        if self.titleH == 0.0 && self.detailH == 0.0 {
            bussonsViewY = self.contentView.popup_bottomY + style.cornerRadius
            buttonOneY = 0.0
        }
        self.buttonsView.frame = CGRect.init(x: 0, y: bussonsViewY, width: self.sheetViewW, height: self.buttonH)
        
        for (index, item) in buttons.enumerated() {
            let buttonY: CGFloat = CGFloat(index) * buttonHeight + buttonOneY
            let button = UIButton.init(type: .custom)
            button.backgroundColor = self.style.popupBgColor
            if index == (buttons.count - 1) { // 最后一个
                button.frame = CGRect.init(x: 0, y: buttonY + 5, width: self.sheetViewW, height: buttonHeight - lineHeight)
                button.setTitleColor(self.style.lastBtnColor, for: .normal)
                button.titleLabel?.font = self.style.lastBtnFont
            }else {
                button.frame = CGRect.init(x: 0, y: buttonY, width: self.sheetViewW, height: buttonHeight - lineHeight)
                button.setTitleColor(self.style.normalBtnColor, for: .normal)
                button.titleLabel?.font = self.style.lastBtnFont
            }
            button.setTitle(item, for: .normal)
            button.setBackgroundImage(UIImage.popup_createImageWithColor(color: UIColor.init(popup_hex: "EBEBEB")), for: .highlighted)
            button.tag = 100 + index
            button.addTarget(self, action: #selector(clickAction(button:)), for: .touchUpInside)
            self.buttonsView.addSubview(button)
        }
    }
    
    /// 按钮选择
    @objc private func clickAction(button: UIButton) {
        self.clickBlock!((button.titleLabel?.text)!, button.tag-100)
        
        self.hideSheetView()
    }
    
    /// show
    public func showSheetView(style: WPPopupStyle?) {
        if style != nil { // 自定义alertView
            self.style = style
            switch self.style.animationOptions {
            case .sheetLeftPop:
                self.center = CGPoint(x: self.popup_width/2, y: ScHeight/2)
            case .sheetRightPop:
                break
            default:
                self.center = CGPoint.init(x: ScWidth / 2.0, y: ScHeight - self.popup_height / 2.0)
                break
            }
        }
        guard let supView: WPPopupView = self.superview as? WPPopupView else {
            return
        }
        kWindowView.addSubview(supView)
        if self.style.touchHide {
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(hideSheetView))
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
            
        case .sheetBottomPop:
            self.layer.position = CGPoint.init(x: ScWidth / 2.0, y: ScHeight + (self.popup_height / 2.0))
            UIView.animate(withDuration: 0.3, animations: {
                if self.style.openEffect {
                    supView.effectView.effect = UIBlurEffect(style: .dark)
                }
                self.layer.position = CGPoint.init(x: ScWidth / 2.0, y: ScHeight - (self.popup_height / 2.0))
            })
            
        case .zoom, .smallToBig, .topToCenter: // 无效
            supView.removeFromSuperview()
        case .sheetLeftPop: // 左侧弹出
            self.layer.position = CGPoint(x: -self.popup_width / 2, y: ScHeight / 2)
            UIView.animate(withDuration: 0.3, animations: {
                if self.style.openEffect {
                    supView.effectView.effect = UIBlurEffect(style: .dark)
                }
                self.layer.position = CGPoint.init(x: self.popup_width/2, y: ScHeight / 2)
            })
            break
        case .sheetRightPop: // 右侧弹出
            break
        }
    }
    
    /// hide
    @objc public func hideSheetView() {
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
            
        case .sheetBottomPop:
            UIView.animate(withDuration: 0.3, animations: {
                if self.style.openEffect {
                    supView.effectView.effect = nil
                }
                self.layer.position = CGPoint.init(x: ScWidth / 2.0, y: ScHeight + self.popup_height )
            }, completion: { (_) in
                supView.removeFromSuperview()
            })
            
        case .zoom, .smallToBig, .topToCenter: // 无效
            break
        case .sheetLeftPop:
            UIView.animate(withDuration: 0.3, animations: {
                if self.style.openEffect {
                    supView.effectView.effect = nil
                }
                self.layer.position = CGPoint(x: -self.popup_width / 2, y: ScHeight / 2)
            }, completion: { (_) in
                supView.removeFromSuperview()
            })
            break
        case .sheetRightPop:
            UIView.animate(withDuration: 0.3, animations: {
                if self.style.openEffect {
                    supView.effectView.effect = nil
                }
                self.layer.position = CGPoint.init(x: ScWidth / 2.0, y: ScHeight + self.popup_height )
            }, completion: { (_) in
                supView.removeFromSuperview()
            })
            break
        }
    }
    
    // 添加圆角
    private func addCornerRadii(_ cornerSize: CGSize, bounds: CGRect) {
        let corrView = UIView(frame: CGRect(x: 0, y: 0, width: self.sheetViewW, height: cornerSize.height))
        corrView.backgroundColor = style.popupBgColor
        self.addSubview(corrView)
        
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft , .topRight], cornerRadii: cornerSize)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
