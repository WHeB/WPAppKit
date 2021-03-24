//
//  AppNavigationBar.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/8/12.
//

import UIKit
import HBDNavigationBar

public extension UIViewController {
    
    /*
     github： https://github.com/listenzz/HBDNavigationBar
     背景的计算规则如下：
     
     1、hbd_barImage 是否有值，如果有，将其设置为背景，否则下一步
     2、hbd_barTintColor 是否有值，如果有，将其设置为背景，否则下一步
     3、[[UINavigationBar appearance] backgroundImageForBarMetrics:UIBarMetricsDefault] 是否有返回值，如果有，将其设置为背景，否则下一步
     4、[UINavigationBar appearance].barTintColor 是否有值，如果有，将其设置为背景，否则下一步
     5、根据 barStyle 计算出默认的背景颜色，并将其设置为背景
     
     如果使用图片来设置背景，并且希望带有透明度，使用带有透明度的图片即可。
     
     如果需要毛玻璃效果，那么设置给 hbd_barTintColor 的值应该带有透明度，具体数值根据色值的不同而不同。
     */
    
    
    
    /// 设置导航栏属性
    ///
    /// - Parameters:
    ///   - barColor: 背景颜色
    ///   - barShadowHidden: 是否隐藏线
    ///   - barHidden: 是否隐藏导航栏
    ///   - barStyle: 状态栏风格
    func customNavigationBar(_ barColor: UIColor,
                                    barShadowHidden: Bool? = false) {
        self.hbd_barTintColor = barColor
        self.hbd_barShadowHidden = barShadowHidden ?? false
    }
    
    /// 设置导航栏标题属性
    ///
    /// - Parameters:
    ///   - barTintColor: 左右标题颜色
    ///   - titleTxtColor: 中间标题颜色
    ///   - titleTxtFont: 中间标题字号
    func customNavigationBar(tintColor: UIColor,
                                    titleTxtColor: UIColor,
                                    titleTxtFont: UIFont) {
        self.hbd_tintColor = tintColor
        self.hbd_titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : titleTxtColor,
            NSAttributedString.Key.font : titleTxtFont
        ]
    }
    
    /// 设置导航栏颜色
    func setBarColor(_ color: UIColor) {
        self.hbd_barTintColor = color
    }
    
    /// 设置导航栏隐藏状态
    func setBarHide(_ hide: Bool) {
        self.hbd_barHidden = hide
    }
    
    /// 设置导航栏线状态
    func setBarShadowHidden(_ hide: Bool) {
        self.hbd_barShadowHidden = hide
    }
    
    /// 设置导航栏透明度
    func setBarAlpha(_ alpha: CGFloat) {
        self.hbd_barAlpha = Float(alpha)
    }
    
    /// 设置导航栏背景图片 （barTintColor会失效）
    func setBarImage(_ image: UIImage) {
        self.hbd_barImage = image
    }
    
    /// 更新导航栏属性设置
    func updateNavigationBarIfNedds() {
        self.hbd_setNeedsUpdateNavigationBar()
    }
    
    /// 当前页面是否可以右滑返回，默认是 YES
    func isEnableSwipeBack(_ enable: Bool) {
        self.hbd_swipeBackEnabled = enable
    }
    
    /// 当前页面是否响应右滑返回或返回按钮返回，默认是 YES
    func isEnableBackInteractive(_ enable: Bool) {
        self.hbd_backInteractive = enable
    }
    
}
