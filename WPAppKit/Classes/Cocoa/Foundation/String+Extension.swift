//
//  String+Extension.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/10.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit
import CommonCrypto

public extension String {
    
    /// 正则表达式匹配
    public func matches(_ pattern: String) -> Bool {
        var reg : NSRegularExpression?
        do{
            reg = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
        }catch{
            reg = nil
        }
        if reg != nil{
            let matches = reg!.matches(in: self, options: [], range:NSMakeRange(0, (self as NSString).length))
            return matches.count > 0
        }
        return false
    }

    /// 字符串比较
    ///
    /// - Parameter str: 待对比字符串
    /// - Returns: 结果
    public func equals(_ str: String?) -> Bool{
        return str == nil ? false : self == str!
    }
    
    /// 字符串比较(忽略大小写)
    ///
    /// - Parameter str: 待对比字符串
    /// - Returns: 结果
    public func equalsIgnoreCase(_ str: String?) -> Bool {
        return str == nil ? false : self.lowercased() == str!.lowercased()
    }
 
    /// 字符串是否以某个字符串开头
    ///
    /// - Parameter with: 开头字符串
    /// - Returns: 结果
    public func start(_ with: String) -> Bool {
        return self.substring(toIndex: with.count) == with
    }
    
    /// 字符串截取(从开头截取到某个位置)
    ///
    /// - Parameter toIndex: 截取到哪个位置
    /// - Returns: 结果
    public func substring(toIndex: Int) -> String {
        return (self as NSString).substring(to: toIndex)
    }
    
    /// 字符串截取(从某个位置截取到最后)
    ///
    /// - Parameter fromIndex: 从哪个位置开始截取
    /// - Returns: 结果
    public func substring(fromIndex: Int) -> String {
        return (self as NSString).substring(from: fromIndex)
    }
    
    /// 字符串截取(从某个位置截取到另一个位置)
    ///
    /// - Parameters:
    ///   - fromIndex: 从哪个位置开始截取
    ///   - toIndex: 截取到哪个位置
    /// - Returns: 结果
    public func substring(fromIndex: Int, toIndex: Int) -> String {
        let range = NSMakeRange(fromIndex, toIndex - fromIndex)
        return (self as NSString).substring(with: range)
    }
    
    /// 字符串截取(从某个位置截取固定长度)
    ///
    /// - Parameters:
    ///   - fromIndex: 从哪个位置开始截取
    ///   - length: 截取长度
    /// - Returns: 结果
    public func substring(fromIndex: Int, length: Int)-> String {
        let range = NSMakeRange(fromIndex, length)
        return (self as NSString).substring(with: range)
    }
    
    /// 字符串替换
    ///
    /// - Parameters:
    ///   - of: 要替换的字符串
    ///   - with: 替换成哪个字符串
    /// - Returns: 结果
    public func replace(_ of: String, with: String) -> String {
        return self.replacingOccurrences(of: of, with: with)
    }
    
    /// url编码
    public func urlEncode() -> String {
        let rfc3986Unreserved = CharacterSet(charactersIn:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~")
        return self.addingPercentEncoding(withAllowedCharacters: rfc3986Unreserved) ?? self
    }
    
    /// url解码
    public func urlDecode() -> String {
        return self.removingPercentEncoding ?? self
    }
 
    /// 字符串切割(可以根据多字符)
    ///
    /// - Parameter char: 切割标志
    /// - Returns: 结果
    public func separate(_ char: String) -> [String] {
        let set = CharacterSet.init(charactersIn: char)
        return self.components(separatedBy: set)
    }
    
    /// 获取汉字拼音
    ///
    /// - Parameter isBlank: 是否要空格
    /// - Returns: 结果
    public func transformToPinyin(isBlank: Bool? = true) -> String {
        let mutableString = NSMutableString(string: self)
        // 结果带音标
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        // 去音标
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        if isBlank! {
            return String(mutableString)
        }
        return String(mutableString).replace(" ", with: "")
    }
    
    /// 获取中英文混合的字节长度
    public func charLength() -> Int {
        var strLength = 0
        for char in self {
            if ("\u{4E00}" <= char  && char <= "\u{9FA5}") { // 中文
                strLength += 2
            }else {
                strLength += 1
            }
        }
        return strLength
    }
    
}


// MARK: stringSize
public extension String {

    /// 获取文本高
    public func txtStringHeight(font: UIFont, maxWidth: CGFloat) -> CGFloat {
        let size = CGSize.init(width: maxWidth, height: CGFloat(MAXFLOAT))
        let dictionary = NSDictionary.init(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        let stringSize = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dictionary as? [NSAttributedStringKey : Any], context: nil)
        return stringSize.height
    }
    
    /// 获取文本宽
    public func txtStringWidth(font: UIFont, maxHeight: CGFloat) -> CGFloat {
        let size = CGSize.init(width: CGFloat(MAXFLOAT), height: maxHeight)
        let dictionary = NSDictionary.init(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        let stringSize = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dictionary as? [NSAttributedStringKey : Any], context: nil)
        return stringSize.width
    }
}


// MARK: jsonString
public extension String {
    
    /// jsonString转字典
    public func toDictionary() -> [String : Any] {
        let jsonData: Data = self.data(using: .utf8)!
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! [String : Any]
        }
        return [:]
    }
    
    /// jsonString转数组
    public func toArray() -> [Any] {
        let jsonData: Data = self.data(using: .utf8)!
        let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if array != nil {
            return array as! [Any]
        }
        return []
    }
}


// MARK: Range
public extension String {
    
    /// Range转换为NSRange
    public func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from!),
                       length: utf16.distance(from: from!, to: to!))
    }
    
    /// Range转换为NSRange
    public func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location,
                                     limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length,
                                   limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
}

// MARK: 加密
public extension String {
    
    /// MD5加密
    public func md5() -> String {
        let cStrl = cString(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue));
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16);
        CC_MD5(cStrl, CC_LONG(strlen(cStrl!)), buffer);
        var md5String = "";
        for idx in 0...15 {
            let obcStrl = String.init(format: "%02x", buffer[idx]);
            md5String.append(obcStrl);
        }
        free(buffer);
        return md5String;
    }
    
    /// base64 编码
    public func base64EncodedString(options: Data.Base64EncodingOptions = []) -> String? {
        let data = self.data(using: .utf8)
        return data?.base64EncodedString(options: options)
    }
    
    /// base64 解码
    public func base64DecodedString(options: Data.Base64DecodingOptions = []) -> String? {
        let base64Data = Data(base64Encoded: self, options: options)
        guard let data = base64Data else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
}



