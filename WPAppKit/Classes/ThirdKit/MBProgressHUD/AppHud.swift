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
    public static func showLoading(_ text: String? = "") {
        let toView = getCurrentViewWithView()
        MBProgressHUD.hide(for: toView, animated: true)
        
        let hud: MBProgressHUD = MBProgressHUD.showAdded(to: toView, animated: true)
        hud.tag = -999
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
    public static func showGifLoading(_ gifName: String) {
        let toView = getCurrentViewWithView()
        MBProgressHUD.hide(for: toView, animated: true)
        
        guard let imgPath = Bundle.main.path(forResource:gifName, ofType:"gif") else {
            return
        }
        
        let hud: MBProgressHUD = MBProgressHUD.showAdded(to: toView, animated: true)
        hud.tag = -999
        hud.mode = MBProgressHUDMode.customView
        hud.isUserInteractionEnabled = false
        hud.removeFromSuperViewOnHide = true
        hud.bezelView.backgroundColor = UIColor.clear
        let imageView = UIImageView()
        imageView.loadBundleGif(imgPath)
        hud.customView = imageView
    }
    
    /// 隐藏提示
    public static func hideHudView() {
        let toView = getCurrentViewWithView()
        if let view: MBProgressHUD = toView.viewWithTag(-999) as? MBProgressHUD {
            view.hide(animated: true)
        }else {
            MBProgressHUD.hide(for: toView, animated: true)
        }
    }
}

extension AppHud {
    
    // 获取当前view
    private static func getCurrentViewWithView() -> UIView {
        return UIApplication.shared.windows.last!
    }
}
