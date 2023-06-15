//
//  +StringCheck.swift
//  WPAppKit
//
//  Created by 王鹏 on 2020/7/16.
//

import UIKit

public extension String {
    
    /// 为空判断，用于输入校验（" "也算空）
    var isBlank: Bool {
        let tempString = self.trimmingCharacters(in: .whitespaces)
        return tempString.isEmpty
    }
    
    /// 验证大陆手机号
    var is86PhoneNumber: Bool {
        let phoneRegex = "^1[3456789]\\d{9}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: self)
    }
    
    /// 验证邮箱
    var isEmail: Bool {
        let regex = "^(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    /// 校验密码(6 - 12位 数字或字母)
    var isValidPassword: Bool {
        let passwordRegex = "^[a-zA-Z0-9]{8,16}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: self)
    }
    
    /// 校验url
    var isURL: Bool {
        guard let url = URL(string: self) else { return false }
        return true
    }
    
    var isValidSchemedUrl: Bool {
        guard let url = URL(string: self),
              let scheme = url.scheme else { return false }
        return true
    }
    
    /// 检查字符串是否是一个有效的https URL
    var isValidHttpsUrl: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme == "https"
    }
    
    /// 检查字符串是否是一个有效的http URL
    var isValidHttpUrl: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme == "http"
    }
    
    /// 检查字符串是否是一个有效的文件URL
    var isValidFileUrl: Bool {
        return URL(string: self)?.isFileURL ?? false
    }
    
    /// 是否身份证号(只限制二代身份证)
    var isChineseCardId: Bool {
        // 1、18位
        if self.count != 18 {
            return false
        }
        // 2、正则表达式
        let pattern = "^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$"
        let regular: NSRegularExpression = try! NSRegularExpression.init(pattern: pattern, options: .caseInsensitive)
        let resultCount: Int = regular.numberOfMatches(in: self, options: .reportProgress, range: NSRange.init(location: 0, length: self.count))
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
            let idValue = (self as NSString).substring(with: NSRange.init(location: i, length: 1))
            idSun += Int(idValue)! * factorArray[i]
        }
        // 对11取余
        let idCardMod: Int = idSun % 11
        // 获取最后一位
        let idCardLast = (self as NSString).substring(with: NSRange.init(location: self.count-1, length: 1))
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
    
    /// 自定义检测内容
    private static func customCheck(regular: String, content: String) -> Bool {
        let pattern = regular
        let regular: NSRegularExpression = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let resultCount: Int = regular.numberOfMatches(in: content, options: .reportProgress, range: NSRange.init(location: 0, length: content.count))
        return resultCount >= 1 ? true : false
    }
    
}

public extension String {
    
    /// 检查字符串是否包含一个或多个字母
    var hasLetters: Bool {
        return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
    /// 仅仅有字母
    var hasOnlyLetters: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        return hasLetters && !hasNumbers
    }
    
    /// 检查字符串是否包含一个或多个数字
    var hasNumbers: Bool {
        return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
    }
    
    /// 检查字符串是否只包含数字
    var hasOnlyNumbers: Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }
    
    /// 是否包含至少一个字母和一个数字
    var isAlphaNumeric: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        let comps = components(separatedBy: .alphanumerics)
        return comps.joined(separator: "").count == 0 && hasLetters && hasNumbers
    }
    
    /// 是否有中文
    var hasChinese: Bool {
        for char in self {
            if ("\u{4E00}" <= char  && char <= "\u{9FA5}") {
                return true
            }
        }
        return false
    }
    
}
