//
//  AppKingfisher.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/28.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit
import Kingfisher

public extension UIImageView {

    /// 设置网络图片
    func king_Image(imgUrl: String, placeholderImg: UIImage? = nil) -> Void {
        guard let url = URL(string: imgUrl) else {
            image = placeholderImg
            return
        }

        kf.setImage(with: url, placeholder: placeholderImg, options: [], progressBlock: nil) { (_, _, _, _) in

        }
    }
}

public extension UIButton {

    /// 为button设置网络图片
    func king_Image(imgUrl: String, placeholderImg: UIImage? = nil) -> Void {
        guard let url = URL(string: imgUrl) else {
            setImage(placeholderImg, for: .normal)
            return
        }
        kf.setImage(with: url, for: .normal, placeholder: placeholderImg, options: nil, progressBlock: nil, completionHandler: nil)
    }

    /// 为button设置背景图片
    func king_BgImage(imgUrl: String, placeholderImg: UIImage? = nil) -> Void {
        guard let url = URL(string: imgUrl) else {
            setBackgroundImage(placeholderImg, for: .normal)
            return
        }
        kf.setBackgroundImage(with: url, for: .normal, placeholder: placeholderImg, options: nil, progressBlock: nil, completionHandler: nil)
    }
}

public class KFImageCacheManager: NSObject {

    /// 设置缓存时间 (默认一周)
    public static func cacheTime(day: Int) {
        ImageCache.default.maxCachePeriodInSecond = TimeInterval(day * 24 * 60 * 60)
    }

    /// 立即清除内存缓存
    public static func clearMemoryCache() {
        ImageCache.default.clearMemoryCache()
    }

    /// 清除磁盘缓存（异步操作）
    public static func clearDiskCache() {
        ImageCache.default.clearDiskCache()
    }

    /// 清理
    public static func cleanExpiredDiskCache() {
        ImageCache.default.cleanExpiredDiskCache()
    }
}
