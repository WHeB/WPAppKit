//
//  Array+Extension.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/10.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import Foundation

public extension Array {
    
    /// 数组转jsonString
    func toJsonString() -> String {
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
    func shuffle() -> [Any] {
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
    func isContains<T: Equatable>(element: T) -> Bool {
        guard let array: [T] = self as? [T]  else {
            return false
        }
        return array.contains {
            return $0 == element
        }
    }
    
    /// 移除元素
    func remove<T: Equatable>(element: T) -> [T] {
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
    func remove<T: Equatable>(atArray: [T]) -> [T] {
        guard let array: [T] = self as? [T]  else {
            return []
        }
        return array.filter {
            !atArray.isContains(element: $0)
        }
    }
    
    /// 找出数组中的元素
    // let one = groups.findElement {return $0 == 1}
    func findElement(match:(Element) -> Bool) -> Element? {
        for element in self where match(element){
            return element
        }
        return nil
    }
}
