//
//  +Collection.swift
//  WPAppKit
//
//  Created by 王鹏 on 2020/7/16.
//

import UIKit

public extension Collection {
    
    /// 根据下标获取元素
    //  let arr = [1, 2, 3, 4, 5]
    //  arr[safe: 1] -> 2
    //  arr[safe: 10] -> nil
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    
    /// 数据分组
    //  [0, 2, 4, 7].group(by: 2) -> [[0, 2], [4, 7]]
    //  [0, 2, 4, 7, 6].group(by: 2) -> [[0, 2], [4, 7], [6]]
    func group(by size: Int) -> [[Element]]? {
        guard size > 0, !isEmpty else { return nil }
        var start = startIndex
        var slices = [[Element]]()
        while start != endIndex {
            let end = index(start, offsetBy: size, limitedBy: endIndex) ?? endIndex
            slices.append(Array(self[start..<end]))
            start = end
        }
        return slices
    }
    
}


public extension Collection where Index == Int {
    
    /// 获取满足条件的下标
    //  [1, 7, 1, 2, 4, 1, 8].indices(where: { $0 == 1 }) -> [0, 2, 5]
    func indices(where condition: (Element) throws -> Bool) rethrows -> [Index]? {
        var indicies: [Index] = []
        for (index, value) in lazy.enumerated() where try condition(value) {
            indicies.append(index)
        }
        return indicies.isEmpty ? nil : indicies
    }
    
    /// 数据分组获取
    //  [0, 2, 4, 7, 6].forEach(slice: 2) { print($0) } -> // print: [0, 2], [4, 7], [6]
    func forEach(slice: Int, body: ([Element]) throws -> Void) rethrows {
        guard slice > 0, !isEmpty else { return }

        var value: Int = 0
        while value < count {
            try body(Array(self[Swift.max(value, startIndex)..<Swift.min(value + slice, endIndex)]))
            value += slice
        }
    }
    
}


public extension Collection where Element == IntegerLiteralType, Index == Int {
    
    /// 元素的平均值
    func average() -> Double {
        return isEmpty ? 0 : Double(reduce(0, +)) / Double(count)
    }
    
}

public extension Collection where Element: FloatingPoint {
    
    /// 元素的平均值
    //  [1.2, 2.3, 4.5, 3.4, 4.5].average() = 3.18
    func average() -> Element {
        guard !isEmpty else { return 0 }
        return reduce(0, {$0 + $1}) / Element(count)
    }
    
}
