//
//  UIViewController+Extension.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/10.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    /// 添加子控制器
    func add(childViewController: UIViewController) {
        addChildViewController(childViewController)
        view.addSubview(childViewController.view)
        childViewController.didMove(toParentViewController: self)
    }
    
    /// 添加子控制器
    func add(childViewController: UIViewController, subView: UIView) {
        addChildViewController(childViewController)
        subView.addSubview(childViewController.view)
        childViewController.didMove(toParentViewController: self)
    }
    
    /// 移除子控制器
    func remove(childViewController: UIViewController) {
        childViewController.willMove(toParentViewController: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParentViewController()
    }
    
    /// push
    func push(viewController : UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    /// pop
    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// popToRoot
    func popToRoot() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    /// pop到指定控制器
    ///
    /// - Parameter backNum: 回退几个 大于栈中元素个数 会直接到根
    func popTo(_ backNum: Int) {
        guard let vcs = self.navigationController?.viewControllers else { return }
        if vcs.count - 1 - backNum < 0 {
            self.navigationController?.popToRootViewController(animated: true)
            return
        }
        let vc = vcs[vcs.count - 1 - backNum]
        self.navigationController?.popToViewController(vc, animated: true)
    }
    
    /// pop到指定控制器
    ///
    /// - Parameter index: 指定下标
    func popToController(_ index: Int) {
        guard let vcs = self.navigationController?.viewControllers else { return }
        if index > vcs.count - 1 { return }
        let vc = vcs[index]
        self.navigationController?.popToViewController(vc, animated: true)
    }
    
    /// pop到指定控制器
    ///
    /// - Parameter className: 指定控制器
    func popToViewController(_ className: String) {
        let clsName: String = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        guard let vcs = self.navigationController?.viewControllers,
            let vc: AnyClass = NSClassFromString(clsName + "." + className)
            else { return }
        vcs.forEach {
            if $0.isKind(of: vc) {
                self.navigationController?.popToViewController($0, animated: true)
            }
        }
    }
    
    /// 模态跳转
    func present(_ viewController: UIViewController) {
        self.navigationController?.present(viewController, animated: true, completion: nil)
    }
    
    /// 跨页面跳转
    func resetVCS(backNum: Int? = 1, vc: UIViewController) {
        guard self.isPush(),
            let num = backNum,
            let vcArray =  self.navigationController?.viewControllers else {
                return
        }
        if vcArray.count < num {
            return
        }
        var vcResult: [UIViewController] = vcArray
        for _ in 0..<num {
            vcResult.removeLast()
        }
        vcResult.append(vc)
        self.navigationController?.setViewControllers(vcResult, animated: true)
    }
    
    /// 弹一个窗口
    func presentPop(_ viewController : UIViewController) {
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overCurrentContext
        self.present(viewController, animated: true, completion: nil)
    }
    
    /// 模态返回
    func dismiss() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    /// 判断当前控制器是不是push弹出
    func isPush() -> Bool {
        guard let viewcontrollers = self.navigationController?.viewControllers else {
            return false
        }
        if viewcontrollers.count > 1 &&
            viewcontrollers[viewcontrollers.count - 1] == self {
            return true
        }
        return false
    }
    
    /// pop 或 dismiss
    func backLastController() {
        if let navCtr = self.navigationController{
            navCtr.popViewController(animated: true)
        }else{
            self.dismiss(animated: true)
        }
    }
    
    /// 系统alertView
    func showAlertView(title: String? = nil,
                       message: String? = nil,
                       actionItems: [UIAlertAction]) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        for action in actionItems {
            alertController.addAction(action)
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// 系统sheetView
    func showSheetView(title: String? = nil,
                       message: String? = nil,
                       actionItems: [UIAlertAction]) {
        let sheetController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .actionSheet)
        for action in actionItems {
            sheetController.addAction(action)
        }
        self.present(sheetController, animated: true, completion: nil)
    }
    
    /// 跳转到App Store
    func pushAppStore(url: String) {
        guard let urlPath = URL.init(string: url) else { return }
        UIApplication.shared.openURL(urlPath)
    }
    
    /// 跳转到<<设置>>界面
    func pushSystemSetting() {
        guard let urlPath = URL.init(string: UIApplicationOpenSettingsURLString) else { return }
        UIApplication.shared.openURL(urlPath)
    }
    
    /// 设置状态栏背景颜色
    func setStatus(backgroundColor: UIColor) {
        if #available(iOS 13.0, *) {
            let barView = UIView(frame: UIApplication.shared.statusBarFrame)
            barView.backgroundColor = backgroundColor
            UIApplication.shared.keyWindow?.addSubview(barView)
        }else {
            let barWindow: UIView = UIApplication.shared.value(forKey: "statusBarWindow") as! UIView
            let barView: UIView = barWindow.value(forKey: "statusBar") as! UIView
            barView.backgroundColor = backgroundColor
        }
    }
}

public extension UIViewController {
    
    /// 监听键盘
    func addKeyboardMonitor() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notifi:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notifi:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notifi: Notification) {
        if let nInfo = (notifi as Notification).userInfo,
            let value = nInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let frame = value.cgRectValue
            keyboardWillShowWithFrame(frame)
        }
    }
    
    @objc func keyboardWillHide(notifi: Notification) {
        if let nInfo = (notifi as Notification).userInfo,
            let value = nInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let frame = value.cgRectValue
            keyboardWillHideWithFrame(frame)
        }
    }
    
    @objc open func keyboardWillShowWithFrame(_ frame: CGRect) {
        
    }
    
    @objc open func keyboardWillHideWithFrame(_ frame: CGRect) {
        
    }
}

public extension UIViewController {
    enum ItemType {
        case leftItem
        case rightItem
    }
    
    /// 添加文字item
    func customTxtItem(type: ItemType, title: String, titleColor: UIColor? = UIColor.black, titleFont: UIFont? = UIFont.systemFont(ofSize: 15), action: Selector) -> UIBarButtonItem {
        let itemButton = UIButton(type: .custom)
        itemButton.setTitle(title, for: .normal)
        let appearanceNavBar = UINavigationBar.appearance()
        if appearanceNavBar == NSNull() {
            itemButton.setTitleColor(titleColor, for: .normal)
        }else {
            itemButton.setTitleColor(appearanceNavBar.tintColor, for: .normal)
        }
        itemButton.sizeToFit()
        itemButton.width = itemButton.width < 40 ? 40 : itemButton.width
        itemButton.height = itemButton.height < 40 ? 40 : itemButton.height
        itemButton.titleLabel?.font = titleFont
        switch type {
        case .leftItem:
            itemButton.contentHorizontalAlignment = .left
        case .rightItem:
            itemButton.contentHorizontalAlignment = .right
        }
        itemButton.addTarget(self, action: action, for: .touchUpInside)
        let item = UIBarButtonItem(customView: itemButton)
        return item
    }
    
    /// 添加图片item
    func customImgItem(type: ItemType, image: UIImage?, imageSize: CGSize? = CGSize(width: 40, height: 40), action: Selector) -> UIBarButtonItem {
        let itemButton = UIButton(type: .custom)
        itemButton.setImage(image, for: .normal)
        var imgSize = itemButton.imageView?.bounds.size
        if #available(iOS 11.0, *) {
            imgSize = itemButton.imageView?.bounds.size
        }else {
            imgSize = imageSize
        }
        if let imgS = imgSize, imgS.width < 40 {
            imgSize = CGSize(width: 40, height: 40)
        }
        itemButton.frame = CGRect.init(origin: CGPoint.zero, size: imgSize ?? CGSize(width: 40, height: 40))
        
        switch type {
        case .leftItem:
            itemButton.contentHorizontalAlignment = .left
        case .rightItem:
            itemButton.contentHorizontalAlignment = .right
        }
        itemButton.addTarget(self, action: action, for: .touchUpInside)
        let item = UIBarButtonItem(customView: itemButton)
        return item
    }
    
}
