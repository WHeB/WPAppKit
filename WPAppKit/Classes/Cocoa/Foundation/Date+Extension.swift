//
//  Date+Extension.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/10.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

public extension Date {

    /// 年
    public var year: Int {
        return Calendar.current.component(.year, from: self as Date)
    }
    
    /// 月
    public var month: Int {
        return Calendar.current.component(.month, from: self as Date)
    }
    
    /// 日
    public var day: Int {
        return Calendar.current.component(.day, from: self as Date)
    }
    
    /// 时
    public var hour: Int {
        return Calendar.current.component(.hour, from: self as Date)
    }
    
    /// 分
    public var minute: Int {
        return Calendar.current.component(.minute, from: self as Date)
    }
    
    /// 秒
    public var second: Int {
        return Calendar.current.component(.second, from: self as Date)
    }
    
    /// 今天是本周的第几天（范围1-7 注：周日为第一天）
    public var weekday: Int {
        return Calendar.current.component(.weekday, from: self as Date)
    }
    
    /// 今天是本月的第几周（最多为6个周）
    public var weekOfMonth: Int {
        return Calendar.current.component(.weekOfMonth, from: self as Date)
    }
    
    /// 今天是本年的第几周（最多为53个周）
    public var weekOfYear: Int {
        return Calendar.current.component(.weekOfYear, from: self as Date)
    }
    
    /// 今天是周几
    public func week() -> String {
        let weekIndex = self.weekday
        switch weekIndex {
        case 0:
            return "周日"
        case 1:
            return "周一"
        case 2:
            return "周二"
        case 3:
            return "周三"
        case 4:
            return "周四"
        case 5:
            return "周五"
        case 6:
            return "周六"
        default:
            break
        }
        return "未取到数据"
    }
    
    /// 是否是今天
    public func isToday() -> Bool {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        let dateStr = fmt.string(from: self)
        let nowStr = fmt.string(from: Date())
        return dateStr == nowStr
    }
    
    /// 判断是否为昨天
    public func isYesterday() -> Bool {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        
        let dateStr = fmt.string(from: self)
        let date = fmt.date(from: dateStr)
        
        var now = Date()
        let nowStr = fmt.string(from: now)
        now = fmt.date(from: nowStr)!
        
        let calender = Calendar.current
        let comps = calender.dateComponents([.year, .month, .day], from: date!, to: now)
        return comps.year == 0 && comps.month == 0 && comps.day == 1;
    }
    
    /// 判断某个时间是否为今年
    public func isThisYear() -> Bool {
        let calender = Calendar.current
        let yearComps = calender.component(Calendar.Component.year, from: self)
        let nowComps = calender.component(Calendar.Component.year, from: Date())
        return yearComps == nowComps
    }
    
    /// 两个时间是否在同一周
    ///
    /// - Parameter date: 待对比日期
    /// - Returns: 结果
    public func isEqualWeek(date: Date) -> Bool {
        if (fabs(self.timeIntervalSince(date))) >= 7 * 24 * 3600 {
            return false
        }
        var calender = NSCalendar.current
        calender.firstWeekday = 2
        let countSelf = calender.component(Calendar.Component.year, from: self)
        let countDate = calender.component(Calendar.Component.year, from: date)
        return countSelf == countDate
    }
    
    /// 多长时间以前
    // numericDates 是否是数字时间 例如：1个月前 显示 上个月
    public func timeAgoSinceDate(numericDates: Bool? = true) -> String {
        let calendar = Calendar.current
        let now = Date()
        let earliest = (now as NSDate).earlierDate(self)
        let latest = (earliest == now) ? self : now
        let components: DateComponents = (calendar as NSCalendar).components([
            NSCalendar.Unit.minute,
            NSCalendar.Unit.hour,
            NSCalendar.Unit.day,
            NSCalendar.Unit.weekOfYear,
            NSCalendar.Unit.month,
            NSCalendar.Unit.year,
            NSCalendar.Unit.second
            ], from: earliest, to: latest, options: NSCalendar.Options())
        
        if components.year! >= 2 {
            return "\(components.year!) 年前"
        } else if components.year! >= 1 {
            if numericDates! {
                return "1 年前"
            } else {
                return "去年"
            }
        } else if components.month! >= 2 {
            return "\(components.month!) 月前"
        } else if components.month! >= 1 {
            if numericDates! {
                return "1 个月前"
            } else {
                return "上个月"
            }
        } else if components.weekOfYear! >= 2 {
            return "\(components.weekOfYear!) 周前"
        } else if components.weekOfYear! >= 1 {
            if numericDates! {
                return "1 周前"
            } else {
                return "上一周"
            }
        } else if components.day! >= 2 {
            return "\(components.day!) 天前"
        } else if components.day! >= 1 {
            if numericDates! {
                return "1 天前"
            } else {
                return "昨天"
            }
        } else if components.hour! >= 2 {
            return "\(components.hour!) 小时前"
        } else if components.hour! >= 1 {
            return "1 小时前"
        } else if components.minute! >= 2 {
            return "\(components.minute!) 分钟前"
        } else if components.minute! >= 1 {
            return "1 分钟前"
        } else {
            return "刚刚"
        }
    }
    
}


/**
G: 公元时代，例如AD公元
yy: 年的后2位
yyyy: 完整年
MM: 月，显示为1-12
MMM: 月，显示为英文月份简写,如 Jan
MMMM: 月，显示为英文月份全称，如 Janualy
dd: 日，2位数表示，如02
d: 日，1-2位显示，如 2
EEE: 简写星期几，如Sun
EEEE: 全写星期几，如Sunday
aa: 上下午，AM/PM
H: 时，24小时制，0-23
K：时，12小时制，0-11
m: 分，1-2位
mm: 分，2位
s: 秒，1-2位
ss: 秒，2位
S: 毫秒
*/
