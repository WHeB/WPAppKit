//
//  +Dictionary.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/10.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import Foundation

public extension Dictionary {
    
    /// 从字典中删除keys参数中包含的所有键
    //  dict.removeAll(keys: ["key1", "key2"])
    mutating func removeAll<S: Sequence>(keys: S) where S.Element == Key {
        keys.forEach { removeValue(forKey: $0) }
    }
    
    /// 检查键是否存在于字典中
    //  dict.has(key: "testKey") -> true
    func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }
    
    /// 字典合并
    /// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: dictionary
    /// - Returns: 新dictionary
    static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        var result = lhs
        rhs.forEach { result[$0] = $1 }
        return result
    }
    
    /// 合并到第一个字典
    /// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: dictionary
    static func += (lhs: inout [Key: Value], rhs: [Key: Value]) {
        rhs.forEach { lhs[$0] = $1}
    }
    
    /// 根据Key移除
    /// let result = dict-["key1", "key2"]
    /// - Parameters:
    ///   - lhs: dictionary
    ///   - keys: [key]
    /// - Returns: dictionary
    static func - <S: Sequence>(lhs: [Key: Value], keys: S) -> [Key: Value] where S.Element == Key {
        var result = lhs
        result.removeAll(keys: keys)
        return result
    }
    
    /// 根据Key移除
    /// dict-=["key1", "key2"]
    /// - Parameters:
    ///   - lhs: dictionary
    ///   - keys: [key]
    static func -= <S: Sequence>(lhs: inout [Key: Value], keys: S) where S.Element == Key {
        lhs.removeAll(keys: keys)
    }
}

public extension Dictionary where Value: Equatable {
    
    /// 根据Value获取对于的Key
    func keys(forValue value: Value) -> [Key] {
        return keys.filter { self[$0] == value }
    }
}


public extension Dictionary {
    
    /// 转JSON Data
    /// - Parameter prettify: 美化数据(默认为假)。
    /// - Returns: JSON Data
    func toJsonData(prettify: Bool? = false) -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        return try? JSONSerialization.data(withJSONObject: self, options: options)
    }
    
    /// 字典转jsonString
    /// - Parameter prettify: 美化数据(默认为假)。
    /// - Returns: jsonString
    func toJsonString(prettify: Bool? = false) -> String? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: options) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
    
    /// 字典转URL参数
    func toURLParameter() -> String {
        guard let dict = (self as AnyObject) as? [String: Any] else {
            return ""
        }
        let dictSortArray = dict.sorted {
            return $0.key < $1.key
        }
        let dictArr = dictSortArray.map { (key, value) -> String in
            return String(format:"%@=%@",key, String(describing: value))
        }
        return dictArr.joined(separator: "&")
    }
    
}
