//
//  HomeViewController.swift
//  WPEmptyView
//
//  Created by admin on 2018/12/18.
//  Copyright © 2018年 wangpeng. All rights reserved.
//

import UIKit
import WPAppKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Popup Demo"
        self.view.addSubview(self.tableView)
    }
    
    lazy var styleData: [String] = {
        let array = [
            "Alert 单按钮",
            "Alert 双按钮",
            "Alert 多按钮",
            "Alert 长detail内容",
            "Alert 自定义",
            "SheetView ",
            "Sheet 自定义",
            "BubbleView"
        ]
        return array
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView.init()
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return styleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.styleData[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            self.showAlertOneButton()
        }else if indexPath.row == 1 {
            self.showAlertDoubleButton()
        }else if indexPath.row == 2 {
            self.showAlertMoreButton()
        }else if indexPath.row == 3 {
            self.showAlertLongDetail()
        }else if indexPath.row == 4 {
            self.showCustomView()
        }else if indexPath.row == 5 {
            self.showSheetView()
        }else if indexPath.row == 6 {
            self.showCustomSheetView()
        }else if indexPath.row == 7 {
            self.showBubbleView()
        }
    }
    
    lazy var customView: WPAlertView = {
        let view = WPAlertView.init(frame: CGRect.init(x: 0, y: 0, width: 300, height: 200))
        view.backgroundColor = UIColor.orange
        let button = UIButton.init(frame: CGRect.init(x: 230, y: 20, width: 50, height: 30))
        button.setTitle("取消", for: .normal)
        button.addTarget(self, action: #selector(hideAlertView), for: .touchUpInside)
        view.addSubview(button)
        return view
    }()
    
    lazy var sheetView: WPSheetView = {
        let view = WPSheetView.init(frame: CGRect.init(x: 0, y: 0, width: 375, height: 500))
        view.backgroundColor = UIColor.orange
        let button = UIButton.init(frame: CGRect.init(x: ScreenWidth - 80, y: 20, width: 50, height: 30))
        button.setTitle("取消", for: .normal)
        button.addTarget(self, action: #selector(hideSheetView), for: .touchUpInside)
        view.addSubview(button)
        return view
    }()
    
    @objc func hideAlertView() {
        self.customView.hideAlertView()
    }
    
    @objc func hideSheetView() {
        self.sheetView.hideSheetView()
    }
}

extension HomeViewController {
    
    @objc func showAlertOneButton() {
        let update = "1、修复已知bug；\n2、新增商城模块。"
        var style = WPPopupStyle.init()
        style.detailTextAlignment = .left
        WPPopupView.showAlertView(style: style, title: "版本更新", detail: update, buttons: ["去更新"]) { (_, index) in
            print(index)
        }
    }
    
    @objc func showAlertDoubleButton() {
        var style = WPPopupStyle.init()
        style.animationOptions = .zoom
        let update = "确定退出登录吗？"
        WPPopupView.showAlertView(style: style, title: "退出登录", detail: update, buttons: ["取消", "确定"]) { (_, index) in
            print(index)
        }
    }
    
    @objc func showAlertMoreButton() {
        var style = WPPopupStyle.init()
        style.lastBtnColor = UIColor.red
        style.openEffect = true
        WPPopupView.showAlertView(style: style, title: "请选择支付方式", buttons: ["银行卡", "微信", "支付宝", "取消"]) { (_, index) in
            print(index)
        }
        WPPopupView.resetStyle(titleColor: UIColor.orange, titleFont: UIFont.systemFont(ofSize: 17), itemIndex: 2)
    }
    
    @objc func showAlertLongDetail() {
        let update = "消息好长啊啊啊消息好消息好长啊啊啊消息好消息好长啊啊啊消息好消息好长啊啊啊消息好消息好长啊啊啊消息好消息好长啊啊啊消息好长啊啊啊消息好消息好长啊啊啊消息好消息好长啊啊啊消息好消息好长啊啊啊消息好消息好长啊啊啊消息好消息好长啊啊啊"
        var style = WPPopupStyle.init()
        style.detailTextAlignment = .left
        WPPopupView.showAlertView(style: style, title: "用户协议", detail: update, buttons: ["好的"]) { (_, index) in
            print(index)
        }
    }
    
    @objc func showCustomView() {
        var style = WPPopupStyle.init()
        style.touchHide = true
        style.animationOptions = .topToCenter
        style.hasKeyboard = true
        WPPopupView.showCustomAlertView(style: style, view: self.customView)
    }
    
    @objc func showCustomSheetView() {
        var style = WPPopupStyle.init()
        style.animationOptions = .buttomPop
        style.touchHide = true
        WPPopupView.showCustomSheetView(style: style, view: self.sheetView)
    }
    
    @objc func showSheetView() {
        var style = WPPopupStyle.init()
        style.lastBtnColor = UIColor.red
        style.animationOptions = .buttomPop
        style.cornerRadius = 8
        WPPopupView.showSheetView(style: style, title: nil, detail: "测试", buttons: ["拍照", "从相册选择","取消"]) { (_, index) in
            print(index)
        }
    }
    
    @objc func showBubbleView() {
        let vc = BubbleViewController.init()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
