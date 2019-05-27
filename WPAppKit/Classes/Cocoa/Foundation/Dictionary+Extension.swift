//
//  Dictionary+Extension.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/10.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import Foundation

public extension Dictionary {
    
    /// 字典拼接
    public mutating func append(dictionary: Dictionary) -> Dictionary {
        dictionary.forEach { (key, value) in
            self.updateValue(value, forKey: key)
        }
        return self
    }
    
    /// 字典转jsonString
    public func toJsonString() -> String {
        guard let dict = (self as AnyObject) as? [String: Any],
            JSONSerialization.isValidJSONObject(dict) else {
            return ""
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions(rawValue: 0))
            if let string = String(data: data, encoding: String.Encoding.utf8) {
                return string
            }
        } catch {
            print(error)
        }
        return ""
    }
    
    /// 字典转URL参数
    public func toURLParameter() -> String {
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
