//
//  AppHud.swift
//  ThirdKit
//
//  Created by 王鹏 on 2019/4/28.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

public class AppHud: NSObject {
    
    /// 显示文字提示窗
    public static func showToast(_ text: String, delay: Double? = 1.5) {
        let toView = getCurrentViewWithView()
        MBProgressHUD.hide(for: toView, animated: true)

        let hud: MBProgressHUD = MBProgressHUD.showAdded(to: toView, animated: true)
        hud.isUserInteractionEnabled = false
        hud.removeFromSuperViewOnHide = true
        hud.margin = 15
        hud.mode = MBProgressHUDMode.text
        hud.bezelView.backgroundColor = UIColor.black
        hud.label.text = text
        hud.label.textColor = UIColor.white
        hud.label.font = UIFont.systemFont(ofSize: 16.0)
        hud.label.numberOfLines = 0
        hud.hide(animated: true, afterDelay: delay!)
    }
    
    /// 显示文字 + 图片 提示窗
    public static func showToast(_ text: String, image: UIImage, delay: Double? = 1.5) {
        let toView = getCurrentViewWithView()
        MBProgressHUD.hide(for: toView, animated: true)
        
        let hud: MBProgressHUD = MBProgressHUD.showAdded(to: toView, animated: true)
        hud.isUserInteractionEnabled = false
        hud.removeFromSuperViewOnHide = true
        hud.margin = 15
        hud.mode = MBProgressHUDMode.customView
        hud.customView = UIImageView(image: image)
        hud.bezelView.backgroundColor = UIColor.black
        hud.label.text = text
        hud.label.textColor = UIColor.white
        hud.label.font = UIFont.systemFont(ofSize: 16.0)
        hud.label.numberOfLines = 0
        hud.hide(animated: true, afterDelay: delay!)
    }
    
    /// 显示加载框
    ///
    /// - Parameters:
    ///   - text: 文字提示
    ///   - maskingAlpha: > 0 会锁死界面，不能操作, 一定要移除
    public static func showLoading(_ text: String? = "", maskingAlpha: CGFloat? = 0.00) {
        let toView = getCurrentViewWithView()
        MBProgressHUD.hide(for: toView, animated: true)
        
        var tempView = UIView()
        if maskingAlpha != nil && maskingAlpha! > 0.00  {
            let masking = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
            masking.tag = -100
            masking.backgroundColor = UIColor.black.withAlphaComponent(maskingAlpha!)
            toView.addSubview(masking)
            tempView = masking
        }else {
            tempView = toView
        }
        let hud: MBProgressHUD = MBProgressHUD.showAdded(to: tempView, animated: true)
        hud.tag = -200
        hud.bezelView.backgroundColor = UIColor.black
        hud.mode = MBProgressHUDMode.indeterminate
        hud.isUserInteractionEnabled = false
        hud.removeFromSuperViewOnHide = true
        hud.contentColor = UIColor.white
        hud.label.text = text
        hud.label.textColor = UIColor.white
        hud.label.font = UIFont.systemFont(ofSize: 16.0)
        hud.label.numberOfLines = 0
    }
    
    /// 显示本地gif动画
    ///
    /// - Parameters:
    ///   - gifName: 动图名称
    ///   - maskingAlpha: > 0 会锁死界面，不能操作, 一定要移除
    public static func showGifLoading(_ gifName: String, maskingAlpha: CGFloat? = 0.00) {
        let toView = getCurrentViewWithView()
        MBProgressHUD.hide(for: toView, animated: true)
        
        guard let imgPath = Bundle.main.path(forResource:gifName, ofType:"gif") else {
            return
        }
        var tempView = UIView()
        if maskingAlpha != nil && maskingAlpha! > 0.00  {
            let masking = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
            masking.tag = -100
            masking.backgroundColor = UIColor.black.withAlphaComponent(maskingAlpha!)
            toView.addSubview(masking)
            tempView = masking
        }else {
            tempView = toView
        }
        let hud: MBProgressHUD = MBProgressHUD.showAdded(to: tempView, animated: true)
        hud.tag = -200
        hud.mode = MBProgressHUDMode.customView
        hud.isUserInteractionEnabled = false
        hud.removeFromSuperViewOnHide = true
        hud.margin = 0
        let imageView = UIImageView()
        imageView.loadBundleGif(imgPath)
        hud.customView = imageView
    }
    
    public static func showGifLoading(images: [UIImage], maskingAlpha: CGFloat? = 0.00) {
        let toView = getCurrentViewWithView()
        MBProgressHUD.hide(for: toView, animated: true)
        
        var tempView = UIView()
        if maskingAlpha != nil && maskingAlpha! > 0.00  {
            let masking = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
            masking.tag = -100
            masking.backgroundColor = UIColor.black.withAlphaComponent(maskingAlpha!)
            toView.addSubview(masking)
            tempView = masking
        }else {
            tempView = toView
        }
        let hud: MBProgressHUD = MBProgressHUD.showAdded(to: tempView, animated: true)
        hud.tag = -200
        hud.mode = MBProgressHUDMode.customView
        hud.isUserInteractionEnabled = false
        hud.removeFromSuperViewOnHide = true
        hud.margin = 0
        let imageView = UIImageView()
        imageView.animationImages = images
        imageView.animationRepeatCount = 0  // 设置为0时无限执行
        imageView.startAnimating()
        hud.customView = imageView
    }
    
    /// 隐藏提示
    public static func hideHudView() {
        let toView = getCurrentViewWithView()
        MBProgressHUD.hide(for: toView, animated: true)
        if let masking = toView.viewWithTag(-100) {
            masking.removeFromSuperview()
        }
    }
}

extension AppHud {
    
    // 获取当前view
    private static func getCurrentViewWithView() -> UIView {
        return UIApplication.shared.windows.last!
    }
    
}
