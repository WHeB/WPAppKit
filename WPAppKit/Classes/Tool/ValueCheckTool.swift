//
//  ValueCheckTool.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/10.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

public class ValueCheckTool: NSObject {
    
    /// 为空判断，用于输入校验（" "也算空）
    public static func isBlank(string: String) -> Bool {
        let array = string.components(separatedBy: " ")
        var tempString = ""
        for (index, item) in array.enumerated() {
            if index != array.count-1 { // 最后一个不拼接
                tempString.append(item + "")
            }else {
                tempString.append(item)
            }
        }
        if tempString.isEmpty {
            return true
        }
        return false
    }
    
    /// 验证大陆手机号
    public static func checkTelNum(telNumber: String) -> Bool {
        let pattern = "^1[2-9][0-9]\\d{8}$"
        let regular: NSRegularExpression = try! NSRegularExpression.init(pattern: pattern, options: .caseInsensitive)
        let resultCount: Int = regular.numberOfMatches(in: telNumber, options: .reportProgress, range: NSRange.init(location: 0, length: telNumber.count))
        return resultCount == 0 ? false : true
    }
    
    /// 校验密码(6 - 12位 数字或字母)
    public static func checkPassword(password: String) -> Bool {
        let pattern = "^[0-9a-zA-Z]{6,12}$"
        let regular: NSRegularExpression = try! NSRegularExpression.init(pattern: pattern, options: .caseInsensitive)
        let resultCount: Int = regular.numberOfMatches(in: password, options: .reportProgress, range: NSRange.init(location: 0, length: password.count))
        return resultCount == 0 ? false : true
    }
    
    /// 校验url
    public static func checkURL(urlString: String) -> Bool {
        let pattern = "^(http|https|ftp)+://[^\\s]*"
        let regular: NSRegularExpression = try! NSRegularExpression.init(pattern: pattern, options: .caseInsensitive)
        let resultCount: Int = regular.numberOfMatches(in: urlString, options: .reportProgress, range: NSRange.init(location: 0, length: urlString.count))
        return resultCount == 0 ? false : true
    }
    
    /// 是否有中文
    public static func checkChinese(string: String) -> Bool {
        for char in string {
            if ("\u{4E00}" <= char  && char <= "\u{9FA5}") {
                return true
            }
        }
        return false
    }
    
    /// 校验身份证号(只限制二代身份证)
    public static func checkCardId(idCard: String) -> Bool {
        // 1、18位
        if idCard.count != 18 {
            return false
        }
        // 2、正则表达式
        let pattern = "^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$"
        let regular: NSRegularExpression = try! NSRegularExpression.init(pattern: pattern, options: .caseInsensitive)
        let resultCount: Int = regular.numberOfMatches(in: idCard, options: .reportProgress, range: NSRange.init(location: 0, length: idCard.count))
        if resultCount == 0 {
            return false
        }
        // 3、GB 11643-1999 校验
        
        // 17位加权因子
        let factorArray = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2]
        // 除以11后产生的余数
        let remainderArray = ["1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2"]
        // 前17位各自乘以加权因子后的总和
        var idSun: Int = 0
        for i in 0..<17 {
            let idValue = (idCard as NSString).substring(with: NSRange.init(location: i, length: 1))
            idSun += Int(idValue)! * factorArray[i]
        }
        // 对11取余
        let idCardMod: Int = idSun % 11
        // 获取最后一位
        let idCardLast = (idCard as NSString).substring(with: NSRange.init(location: idCard.count-1, length: 1))
        // 判断最后一位
        if idCardMod == 2 {
            if idCardLast == "X" || idCardLast == "x" {
                return true
            }else {
                return false
            }
        }else {
            if idCardLast == remainderArray[idCardMod] {
                return true
            }else {
                return false
            }
        }
    }

}
