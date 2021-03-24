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
    func king_Image(imgUrl: String,
                    placeholderImg: UIImage? = nil) -> Void {
        guard let url = URL(string: imgUrl) else {
            image = placeholderImg
            return
        }

        kf.setImage(with: url, placeholder: placeholderImg, options: [], progressBlock: nil) { (_, _, _, _) in

        }
    }
}

public extension UIButton {
    
    func king_Image(imgUrl: String,
                    placeholderImg: UIImage? = nil,
                    state: UIControl.State? = .normal) {
        guard let url = URL(string: imgUrl) else {
            self.setImage(placeholderImg, for: state ?? .normal)
            return
        }
        let urlImage: ImageResource = ImageResource(downloadURL: url)
        kf.setImage(with: urlImage, for: state ?? .normal)
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
