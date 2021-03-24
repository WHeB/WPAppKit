//
//  CacheManage.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/9/12.
//
//  缓存管理

import UIKit
import WebKit

public struct CacheManage {
    
    /// 获取所有缓存大小
    public static func sizeOfAllCache() -> String {
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        var size: Double = 0
        for file in fileArr! {
            let path = (cachePath! as NSString).appending("/\(file)")
            let floder = try! FileManager.default.attributesOfItem(atPath: path)
            for (abc, bcd) in floder {
                if abc == FileAttributeKey.size {
                    size += (bcd as AnyObject).doubleValue
                }
            }
        }
        let cache = size / 1024 / 1024
        return String(format: "%.1fM", cache)
    }
    
    /// 清除所有缓存
    public static func clearAllCache() {
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        for file in fileArr! {
            let path = (cachePath! as NSString).appending("/\(file)")
            if FileManager.default.fileExists(atPath: path) {
                do {
                    try FileManager.default.removeItem(atPath: path)
                } catch {}
            }
        }
    }
    
    /// 清除浏览器缓存
    public static func clearBrowserCache() {
        let dataStore = WKWebsiteDataStore.default()
        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), completionHandler: { (records) in
            for record in records{
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {
                    print("清除成功\(record)")
                })
            }
        })
    }
    
}
