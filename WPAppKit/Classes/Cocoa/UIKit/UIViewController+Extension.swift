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
    public func add(childViewController: UIViewController) {
        addChildViewController(childViewController)
        view.addSubview(childViewController.view)
        childViewController.didMove(toParentViewController: self)
    }
    
    /// 添加子控制器
    public func add(childViewController: UIViewController, subView: UIView) {
        addChildViewController(childViewController)
        subView.addSubview(childViewController.view)
        childViewController.didMove(toParentViewController: self)
    }
    
    /// 移除子控制器
    public func remove(childViewController: UIViewController) {
        childViewController.willMove(toParentViewController: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParentViewController()
    }
    
    /// push
    public func push(viewController : UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    /// pop
    public func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// popToRoot
    public func popToRoot() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    /// pop到指定控制器
    ///
    /// - Parameter backNum: 回退几个 大于栈中元素个数 会直接到根
    public func popTo(_ backNum: Int) {
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
    public func popToController(_ index: Int) {
        guard let vcs = self.navigationController?.viewControllers else { return }
        if index > vcs.count - 1 { return }
        let vc = vcs[index]
        self.navigationController?.popToViewController(vc, animated: true)
    }
    
    /// pop到指定控制器
    ///
    /// - Parameter className: 指定控制器
    public func popToViewController(_ className: String) {
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
    public func present(_ viewController : UIViewController) {
        self.navigationController?.present(viewController, animated: true, completion: nil)
    }
    
    /// 模态返回
    public func dismiss() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    /// 判断当前控制器是不是push弹出
    public func isPush() -> Bool {
        guard let viewcontrollers = self.navigationController?.viewControllers else {
            return false
        }
        if viewcontrollers.count > 1 &&
            viewcontrollers[viewcontrollers.count - 1] == self {
            return true
        }
        return false
    }
    
    /// 系统alertView
    public func showAlertView(title: String? = nil,
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
    public func showSheetView(title: String? = nil,
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
    public func pushAppStore(url: String) {
        guard let urlPath = URL.init(string: url) else { return }
        UIApplication.shared.openURL(urlPath)
    }
    
    /// 跳转到<<设置>>界面
    public func pushSystemSetting() {
        guard let urlPath = URL.init(string: UIApplicationOpenSettingsURLString) else { return }
        UIApplication.shared.openURL(urlPath)
    }
    
    /// 设置状态栏背景颜色
    public func setStatus(backgroundColor: UIColor) {
        let barWindow: UIView = UIApplication.shared.value(forKey: "statusBarWindow") as! UIView
        let barView: UIView = barWindow.value(forKey: "statusBar") as! UIView
        barView.backgroundColor = backgroundColor
    }
    
}
