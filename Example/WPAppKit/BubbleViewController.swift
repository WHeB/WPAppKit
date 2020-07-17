//
//  BubbleViewController.swift
//  PopViewDemo
//
//  Created by admin on 2018/12/21.
//  Copyright © 2018年 wangpeng. All rights reserved.
//

import UIKit
import WPAppKit

class BubbleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.title = "BubbleView"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addItemAction))
        
        self.view.addSubview(self.button1)
        self.view.addSubview(self.button2)
        self.view.addSubview(self.button3)
        self.view.addSubview(self.button4)
    }
    
    @objc func addItemAction() {
        var style = WPPopupStyle.init()
        style.animationOptions = .zoom
        style.popupBgColor = UIColor.black
        style.touchHide = true
        style.labelColor = UIColor.white
        style.lineColor = UIColor.white
        style.triangleOrientation = .top
        style.adjustDistance = 60
        let Y: CGFloat = 88
        let point = CGPoint.init(x: ScreenWidth - 80, y: Y)
        WPPopupView.showBubbleView(startPoint: point, style: style, viewSize: CGSize.init(width: 150, height: 200), imgNameAndTitleArray: [("iconMsg", "发起群聊"), ("iconAdd", "添加朋友"), ("iconScan", "扫一扫"), ("iconPay", "收付款")]) { (string, index) in
            print(string)
            print(index)
        }
    }
    
    lazy var button1: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 150, y: 88, width: 100, height: 30)
        button.setTitle("下侧弹出", for: .normal)
        button.backgroundColor = UIColor.orange
        button.tag = 100
        button.addTarget(self, action: #selector(showPopViewAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var button2: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 50, y: 300, width: 100, height: 30)
        button.setTitle("右侧弹出", for: .normal)
        button.backgroundColor = UIColor.red
        button.tag = 200
        button.addTarget(self, action: #selector(showPopViewAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var button3: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 150, y: 600, width: 100, height: 30)
        button.setTitle("上侧弹出", for: .normal)
        button.backgroundColor = UIColor.purple
        button.tag = 300
        button.addTarget(self, action: #selector(showPopViewAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var button4: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 250, y: 300, width: 100, height: 30)
        button.setTitle("左侧弹出", for: .normal)
        button.backgroundColor = UIColor.green
        button.tag = 400
        button.addTarget(self, action: #selector(showPopViewAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    @objc func showPopViewAction(sender: UIButton) {
        
        var style = WPPopupStyle.init()
        style.animationOptions = .none
        style.popupBgColor = UIColor.white
        style.touchHide = true
        style.labelColor = UIColor.black
        style.lineColor = UIColor.gray
        switch sender.tag {
        case 100:
            style.triangleOrientation = .top
        case 200:
            style.triangleOrientation = .left
        case 300:
            style.triangleOrientation = .buttom
        case 400:
            style.triangleOrientation = .right
        default:
            style.triangleOrientation = .top
        }
        
        let array: ItemArray  = [(imgName: nil, title: "发起群聊"), (imgName: nil, title: "添加朋友"), (imgName: nil, title: "扫一扫"), (imgName: nil, title: "收付款")]
        
        WPPopupView.showBubbleView(fromView: sender, style: style, viewSize: CGSize.init(width: 100, height: 200), imgNameAndTitleArray: array) { (string, index) in
            print(string)
            print(index)
        }
    }
}

