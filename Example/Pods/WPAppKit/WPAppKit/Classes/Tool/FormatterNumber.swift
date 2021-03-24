//
//  FormatterNumber.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/15.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

public class FormatterNumber: NSObject {
    
    /// CLongLong格式化String
    ///
    /// - Parameters:
    ///   - value: 需要格式化的值
    ///   - minIntLen: 最小位数
    ///   - maxIntLen: 最大位数 默认9位
    /// - Returns: 返回String
    public static func formatterInt(value: CLongLong,
                                    minIntLen: Int? = 1,
                                    maxIntLen: Int? = 9,
                                    separator: String? = "",
                                    prefix: String? = "") -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumIntegerDigits = minIntLen!
        formatter.maximumIntegerDigits = maxIntLen!
        formatter.groupingSeparator = separator
        formatter.positivePrefix = prefix
        let result = formatter.string(from: NSNumber(value: value))
        return result!
    }
    
    /// Doubel
    public static func formatterDouble(value: Double? = 0,
                                       minFractionLen: Int? = 0,
                                       maxFractionLen: Int? = 8,
                                       separator: String? = "",
                                       prefix: String? = "") -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = minFractionLen!
        formatter.maximumFractionDigits = maxFractionLen!
        formatter.groupingSeparator = separator
        formatter.positivePrefix = prefix
        let result = formatter.string(from: NSNumber(value: value!))
        return result!
    }
    
    /// 格式化数字string
    public static func formatterString(value: String,
                                       minFractionLen: Int? = 0,
                                       maxFractionLen: Int? = 8,
                                       separator: String? = "",
                                       prefix: String? = "") -> String {
        
        if value.contains(".") {
            guard let tempValue = Double(value) else {
                return "0"
            }
            let result = FormatterNumber.formatterDouble(value: tempValue, minFractionLen: minFractionLen, maxFractionLen: maxFractionLen, separator: separator, prefix: prefix)
            return result
        }else {
            guard let tempValue = CLongLong(value) else {
                return "0"
            }
            let result = FormatterNumber.formatterInt(value: tempValue, minIntLen: minFractionLen, maxIntLen: maxFractionLen, separator: separator, prefix: prefix)
            return result
        }
    }
    
}
