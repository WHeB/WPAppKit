//
//  FormatterTime.swift
//  WPAppKit
//  格式化时间
//  Created by 王鹏 on 2019/4/23.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

public class FormatterTime: NSObject {

    /// 格式化当前时间
    public static func toNow(format: String? = "yyyy/MM/dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: Date())
    }
    
    /// 时间戳转时间
    ///
    /// - Parameters:
    ///   - timestamp: 时间戳
    ///   - format: 格式
    /// - Returns: 结果
    public static func toTime(timestamp: CLong, format: String? = "yyyy/MM/dd HH:mm") -> String {
        let times: TimeInterval = TimeInterval(timestamp)
        let date = Date(timeIntervalSince1970: times)
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    /// 今天几天后
    ///
    /// - Parameters:
    ///   - day: 几天
    ///   - format: 格式
    /// - Returns: 结果
    public static func afterDay(day: Int, format: String? = "yyyy/MM/dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let nextTime: TimeInterval = TimeInterval(24*60*60*day)
        let lastDate = Date.init().addingTimeInterval(nextTime)
        return formatter.string(from: lastDate)
    }
    
    /// 时间字符串转时间戳
    ///
    /// - Parameters:
    ///   - time: 时间
    ///   - format: 格式
    /// - Returns: 结果
    public static func toTimeStamp(time: String, format: String? = "yyyy年MM月dd日") -> CLong {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let date = formatter.date(from: time)
        let dateStamp: TimeInterval = date?.timeIntervalSince1970 ?? 0
        let dateD: CLong = CLong(dateStamp)
        return dateD
    }
    
}
