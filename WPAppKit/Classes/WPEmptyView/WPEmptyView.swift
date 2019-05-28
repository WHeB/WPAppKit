//
//  WPEmptyView.swift
//  WPEmptyView
//
//  Created by admin on 2018/10/25.
//  Copyright © 2018年 wangpeng. All rights reserved.
//

import UIKit

private let stackViewPadding: CGFloat = 20.0
private let stackViewSpacing: CGFloat = 10.0

@available(iOS 9.0, *)
public class WPEmptyView: UIView {
    
    typealias ClickRefresh = (_ view: WPEmptyView) -> Void
    private var callBack: ClickRefresh!
    private var style: WPEmptyStyle!
    private var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect? = CGRect.zero, style: WPEmptyStyle? = nil, title: String, detail: String? = "", imageName: String? = "", buttonTitle: String? = "", clickRefresh: @escaping ClickRefresh) {
        self.init(frame: frame!)
        
        let style = style ?? WPEmptyStyle.init()
        self.backgroundColor = style.emptyBgColor
        self.callBack = clickRefresh
        self.style = style
        
        self.addUI(style: style, title: title, detail: detail!, imageName: imageName!, buttonTitle: buttonTitle!)
        
        self.setViewFrame()
    }
    
    func loadSubviews() {
        guard let supView = self.superview else {
            return
        }
        if self.frame != CGRect.zero {
            return
        }
        self.frame = CGRect.init(x: 0, y: 0, width: supView.bounds.size.width, height: supView.bounds.size.height)
        self.setViewFrame()
    }
    
    private func addUI(style: WPEmptyStyle, title: String, detail: String, imageName: String, buttonTitle: String) {
        
        // img title detail 放到线性布局中
        let stackView = UIStackView.init()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = stackViewSpacing
        self.addSubview(stackView)
        self.stackView = stackView
        
        if imageName.count > 0 {
            self.imgView.image = UIImage.init(named: imageName)
            stackView.addArrangedSubview(self.imgView)
        }
        
        if title.count > 0  {
            self.titleLabel.text = title
            stackView.addArrangedSubview(self.titleLabel)
        }
        
        if detail.count > 0 {
            self.detailLabel.text = detail
            stackView.addArrangedSubview(self.detailLabel)
        }
        
        if buttonTitle.count > 0 {
            self.button.setTitle(buttonTitle, for: .normal)
            self.addSubview(self.button)
            self.button.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        }else {
            self.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(clickAction))
            self.addGestureRecognizer(tap)
        }
    }
    
    lazy var imgView: UIImageView = {
        let imgView = UIImageView.init()
        imgView.contentMode = .center
        return imgView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = self.style.titleColor
        label.font = self.style.titleFont
        return label
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel.init()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = self.style.detailColor
        label.font = self.style.detailFont
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton.init()
        button.backgroundColor = self.style.buttonBgColor
        button.setTitleColor(self.style.buttonTitleColor, for: .normal)
        button.titleLabel?.font = self.style.buttonFont
        if self.style.buttonRadius > 0 {
            button.layer.masksToBounds = true
            button.layer.cornerRadius = self.style.buttonRadius
        }
        if self.style.buttonBorderWidth > 0 {
            button.layer.borderWidth = self.style.buttonBorderWidth
            button.layer.borderColor = self.style.buttonBorderColor.cgColor
        }
        return button
    }()
    
    // 重新加载
    @objc private func clickAction() {
        self.callBack(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

@available(iOS 9.0, *)
extension WPEmptyView {
    
    // 设置emptyView frame
    private func setViewFrame() {
        
        let stackViewW = self.bounds.size.width - 2 * stackViewPadding
        
        let orientation = style.orientation
        var stackViewY: CGFloat = self.style.paddingTop
        switch orientation {
        case .top:
            stackViewY = self.style.paddingTop
            
        case .center:
            let stackButtonViewH = self.getbuttonViewHeight() + self.getStackHeight()
            if stackButtonViewH > self.bounds.size.height {
                stackViewY = 0
            }else {
                stackViewY = (self.bounds.size.height - stackButtonViewH) / 2
            }
        case .bottom:
            stackViewY = self.bounds.size.height - self.getbuttonViewHeight() - self.getStackHeight()
        }
        
        self.stackView.frame = CGRect.init(x: stackViewPadding, y: stackViewY, width: stackViewW, height: self.getStackHeight())
        self.settingButtonFrame()
    }
    
    // 设置button Frame
    private func settingButtonFrame() {
        guard let btnTitle = self.button.titleLabel?.text else {
            return
        }
        if (btnTitle.count) > 0 {
            let buttonY = self.stackView.frame.origin.y + self.stackView.frame.size.height + stackViewPadding
            let buttonW = self.wp_getTxtWidth(string: btnTitle, txtFont: self.style.buttonFont, maxHeight: self.style.buttonHeight) + 4 * stackViewPadding
            let buttonX = (self.frame.size.width - buttonW) / 2
            self.button.frame = CGRect.init(x: buttonX, y: buttonY, width: buttonW, height: self.style.buttonHeight)
        }
    }
    
    // Stack高度
    private func getStackHeight() -> CGFloat {

        let imgH: CGFloat = self.imgView.image == nil ? 0 : self.imgView.image!.size.height
        let titleH = self.wp_getTxtHeight(string: (self.titleLabel.text)!, txtFont: self.style.titleFont, maxWidth: (self.frame.width - stackViewPadding * 2))
        
        let detailH = self.detailLabel.text == nil ? 0 : self.wp_getTxtHeight(string: (self.detailLabel.text)!, txtFont: self.style.titleFont, maxWidth: (self.frame.width - stackViewPadding * 2))
        
        var totalH = stackViewPadding + imgH + titleH + detailH
        if imgH != 0  {
            totalH += stackViewSpacing
        }
        if detailH != 0 {
            totalH += stackViewSpacing
        }
        return totalH
    }
    
    // 获取buttonH + 上下spacimg
    private func getbuttonViewHeight() -> CGFloat {
        guard let _ = self.button.titleLabel?.text else {
            return 0
        }
        return self.style.buttonHeight + stackViewPadding + stackViewSpacing
    }
}

@available(iOS 9.0, *)
extension WPEmptyView {
    // 获取文本高
    private func wp_getTxtHeight(string: String, txtFont: UIFont, maxWidth: CGFloat) -> CGFloat {
        let size = CGSize.init(width: maxWidth, height: CGFloat(MAXFLOAT))
        let stringSize = string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : txtFont], context: nil)
        return stringSize.height
    }
    
    // 获取文本宽
    private func wp_getTxtWidth(string: String, txtFont: UIFont, maxHeight: CGFloat) -> CGFloat {
        let size = CGSize.init(width: CGFloat(MAXFLOAT), height: maxHeight)
        let stringSize = string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : txtFont], context: nil)
        return stringSize.width
    }
}
