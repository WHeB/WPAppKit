//
//  WPPopupView.swift
//  WPPopView
//
//  Created by admin on 2018/10/25.
//  Copyright © 2018年 wangpeng. All rights reserved.
//

import UIKit

public typealias PopupClickButtonBlock = (_ buttonTitle: String, _ index: Int) -> Void

public typealias ItemArray = [(imgName: String?, title: String)]

public class WPPopupView: UIView {
    
    /// 创建AlertView
    public static func showAlertView(style: WPPopupStyle? = WPPopupStyle(), title: String, detail: String? = nil, buttons: [String], clickBlock: @escaping PopupClickButtonBlock) {
        
        let selfView = WPPopupView.init(frame: CGRect(x: 0, y: 0, width: ScWidth, height: ScHeight))
        selfView.effectView.backgroundColor = style?.coverBgColor
        selfView.effectView.alpha = (style?.effectAlpha)!
        selfView.addSubview(selfView.effectView)
        
        let alertView = WPAlertView.init(style: style!, title: title, detail: detail, buttons: buttons, clickBlock: clickBlock)
        selfView.addSubview(alertView)
        alertView.showAlertView(style: nil)
    }
    
    /// 自定义AlertView
    public static func showCustomAlertView(style: WPPopupStyle? = WPPopupStyle.init(), view: WPAlertView) {
        let selfView = WPPopupView.init(frame: CGRect(x: 0, y: 0, width: ScWidth, height: ScHeight))
        selfView.effectView.backgroundColor = style?.coverBgColor
        selfView.effectView.alpha = (style?.effectAlpha)!
        selfView.addSubview(selfView.effectView)
        
        selfView.addSubview(view)
        view.showAlertView(style: style)
    }
    
    /// 创建SheetView
    public static func showSheetView(style: WPPopupStyle? = WPPopupStyle.init(), title: String? = nil, detail: String? = nil, buttons: [String], clickBlock: @escaping PopupClickButtonBlock) {
        
        let selfView = WPPopupView.init(frame: CGRect(x: 0, y: 0, width: ScWidth, height: ScHeight))
        selfView.effectView.backgroundColor = style?.coverBgColor
        selfView.effectView.alpha = (style?.effectAlpha)!
        selfView.addSubview(selfView.effectView)
        
        let sheetView = WPSheetView.init(style: style!, title: title, detail: detail, buttons: buttons, clickBlock: clickBlock)
        selfView.addSubview(sheetView)
        sheetView.showSheetView(style: nil)
    }
    
    /// 自定义WPSheetView
    public static func showCustomSheetView(style: WPPopupStyle? = WPPopupStyle.init(), view: WPSheetView) {
        
        let selfView = WPPopupView.init(frame: CGRect(x: 0, y: 0, width: ScWidth, height: ScHeight))
        selfView.effectView.backgroundColor = style?.coverBgColor
        selfView.effectView.alpha = (style?.effectAlpha)!
        selfView.addSubview(selfView.effectView)
        
        selfView.addSubview(view)
        view.showSheetView(style: style)
    }
    
    /// 创建BubbleView
    public static func showBubbleView(fromView: UIView, style: WPPopupStyle, viewSize: CGSize, imgNameAndTitleArray: ItemArray, clickBlock: @escaping PopupClickButtonBlock) {
        
        let selfView = WPPopupView.init(frame: CGRect(x: 0, y: 0, width: ScWidth, height: ScHeight))
        selfView.effectView.backgroundColor = style.coverBgColor
        selfView.effectView.alpha = style.effectAlpha
        selfView.addSubview(selfView.effectView)
        
        // 防止不是view类型而调用 convert(_ rect: CGRect, to coordinateSpace: UICoordinateSpace) -> CGRect 方法
        if !fromView.isKind(of: UIView.self) {return}
        let window = UIApplication.shared.keyWindow!
        let origin = fromView.convert(fromView.bounds, to: window)
        
        let bubbleView = WPBubbleView.init(fromReact: origin, style: style, viewSize: viewSize, imageNameAndTitle: imgNameAndTitleArray, clickBlock: clickBlock)
        selfView.addSubview(bubbleView)
        bubbleView.showBubbleView()
    }
    
    /// 创建BubbleView
    public static func showBubbleView(startPoint: CGPoint, style: WPPopupStyle, viewSize: CGSize, imgNameAndTitleArray: ItemArray, clickBlock: @escaping PopupClickButtonBlock) {
        
        let selfView = WPPopupView.init(frame: CGRect(x: 0, y: 0, width: ScWidth, height: ScHeight))
        selfView.effectView.backgroundColor = style.coverBgColor
        selfView.effectView.alpha = style.effectAlpha
        selfView.addSubview(selfView.effectView)
        
        let bubbleView = WPBubbleView.init(startPoint: startPoint, style: style, viewSize: viewSize, imageNameAndTitle: imgNameAndTitleArray, clickBlock: clickBlock)
        selfView.addSubview(bubbleView)
        bubbleView.showBubbleView()
    }
    
    /// 重置button样式
    // 注意：谨慎使用 自定义view不要用。主要在alert和sheet中使用
    public static func resetSheetViewStyle(titleColor: UIColor, titleFont: UIFont, itemIndex: Int) {
        let views = CurrentManager.getTopWindow()?.subviews
        guard let popupView: WPPopupView = views?.filter({ (view) -> Bool in
            return view is WPPopupView
        }).first as? WPPopupView else {
            return
        }
        // 拿到目标类型View alert sheet bubble -> 拿到包裹的view
        guard let targetTypeView = popupView.subviews.last else {
                return
        }
        
        let contentView = targetTypeView.subviews[1]
        // 拿到buttons
        guard let buttons: [UIButton] = contentView.subviews.filter({ (view) -> Bool in
            return view is UIButton
        }) as? [UIButton] else {
            return
        }

        let targetButton = buttons[itemIndex]
        targetButton.setTitleColor(titleColor, for: .normal)
        targetButton.titleLabel?.font = titleFont
    }
    
    /// 毛玻璃背景
    lazy var effectView: UIVisualEffectView = {
        let view = UIVisualEffectView.init()
        view.frame = CGRect.init(x: 0, y: 0, width: ScWidth, height: ScHeight)
        view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        return view
    }()
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
