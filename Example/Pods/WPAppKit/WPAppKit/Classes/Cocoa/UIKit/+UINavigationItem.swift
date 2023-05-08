//
//  +UINavigationItem.swift
//  WPAppKit
//
//  Created by 王鹏 on 2020/7/16.
//

import UIKit

public extension UINavigationItem {
    
    /// 设置titleView
    func titleView(with image: UIImage) {
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = image
        titleView = logoImageView
    }
    
    
    
    
}
