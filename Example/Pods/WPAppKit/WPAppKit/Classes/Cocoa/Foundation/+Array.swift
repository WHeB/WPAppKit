//
//  +Array.swift
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
    
    /// 数组交换位置
    mutating func safeSwap(from index: Index, to otherIndex: Index) {
        guard index != otherIndex else { return }
        guard startIndex..<endIndex ~= index else { return }
        guard startIndex..<endIndex ~= otherIndex else { return }
        swapAt(index, otherIndex)
    }
    
}


public extension Array where Element: Equatable {
    
    /// 判断是否包含
    func isContains(match: Element) -> Bool {
        return self.contains {
            return $0 == match
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
    
    /// 移除所有的单个元素
    // [1, 2, 2, 3, 4, 5].removeAll(2) -> [1, 3, 4, 5]
    mutating func removeAll(_ item: Element) -> [Element] {
        removeAll(where: { $0 == item })
        return self
    }
    
    // [1, 2, 2, 3, 4, 5].removeAll([2,5]) -> [1, 3, 4]
    mutating func removeAll(_ items: [Element]) -> [Element] {
        guard !items.isEmpty else { return self }
        removeAll(where: { items.contains($0) })
        return self
    }
    
    /// 根据下标移除元素
    mutating func removeAtIndexes(_ indexs:[Int]) -> () {
        for index in indexs.sorted(by: >) {
            self.remove(at: index)
        }
    }
    
    /// 移除重复元素
    // [1, 2, 2, 3, 4, 5].removeDuplicates() -> [1, 2, 3, 4, 5]
    mutating func removeDuplicates() -> [Element] {
        self = reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
        return self
    }
    
}


public extension Array {
    
    /// 从数组中返回一个随机元素
    public var sample: Element? {
        //如果数组为空，则返回nil
        guard count > 0 else { return nil }
        let randomIndex = Int(arc4random_uniform(UInt32(count)))
        return self[randomIndex]
    }
     
    /// 从数组中从返回指定个数的元素
    ///
    /// - Parameters:
    ///   - size: 希望返回的元素个数
    ///   - noRepeat: 返回的元素是否不可以重复（默认为false，可以重复）
    public func sample(size: Int, noRepeat: Bool = false) -> [Element]? {
        //如果数组为空，则返回nil
        guard !isEmpty else { return nil }
         
        var sampleElements: [Element] = []
         
        //返回的元素可以重复的情况
        if !noRepeat {
            for _ in 0..<size {
                sampleElements.append(sample!)
            }
        }
        //返回的元素不可以重复的情况
        else{
            //先复制一个新数组
            var copy = self.map { $0 }
            for _ in 0..<size {
                //当元素不能重复时，最多只能返回原数组个数的元素
                if copy.isEmpty { break }
                let randomIndex = Int(arc4random_uniform(UInt32(copy.count)))
                let element = copy[randomIndex]
                sampleElements.append(element)
                //每取出一个元素则将其从复制出来的新数组中移除
                copy.remove(at: randomIndex)
            }
        }
        return sampleElements
    }
    
}
