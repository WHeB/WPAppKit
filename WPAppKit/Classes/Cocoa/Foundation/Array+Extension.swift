//
//  Array+Extension.swift
//  WPToolDemo
//
//  Created by 王鹏 on 2019/4/10.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import Foundation

public extension Array {
    
    /// 数组转jsonString
    public func toJsonString() -> String {
        guard let array = (self as AnyObject) as? [Any],
            JSONSerialization.isValidJSONObject(array) else {
            return ""
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: array, options: [])
            if let string = String(data: data, encoding: String.Encoding.utf8) {
                return string
            }
        } catch {
            print(error)
        }
        return ""
    }
    
    /// 数组乱序
    public func shuffle() -> [Any] {
        var list = [Any]()
        for index in 0..<self.count {
            let newIndex = Int(arc4random_uniform(UInt32(list.count-index))) + index
            if index != newIndex {
                list.swapAt(index, newIndex)
            }
        }
        return list
    }
    
    /// 判断是否包含
    public func isContains<T: Equatable>(element: T) -> Bool {
        guard let array: [T] = self as? [T]  else {
            return false
        }
        return array.contains {
            return $0 == element
        }
    }
    
    /// 移除元素
    public func remove<T: Equatable>(element: T) -> [T] {
        guard let array: [T] = self as? [T]  else {
            return []
        }
        if !array.isContains(element: element) {
            return array
        }
        return array.filter{
            $0 != element
        }
    }
    
    /// 数组移除
    public func remove<T: Equatable>(atArray: [T]) -> [T] {
        guard let array: [T] = self as? [T]  else {
            return []
        }
        return array.filter {
            !atArray.isContains(element: $0)
        }
    }
    
}
