//
//  RandomTool.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/11.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

public class RandomTool: NSObject {

    /// 随机色
    public class func randomColor() -> UIColor {
        let red = CGFloat(arc4random() % 256) / 255.0
        let green = CGFloat(arc4random() % 256) / 255.0
        let blue = CGFloat(arc4random() % 256) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    /// 创建随机字符串
    ///
    /// - Parameters:
    ///   - length: 长度
    ///   - isLetter: 是否只要字母
    /// - Returns: 结果
    public class func randomString(length: Int, isLetter: Bool = false) -> String {
        var ch: [CChar] = Array(repeating: 0, count: length)
        for index in 0..<length {
            var num = isLetter ? arc4random_uniform(58) + 65 : arc4random_uniform(75) + 48
            if num > 57 && num < 65 && isLetter == false {
                num = num%57 + 48
            } else if num > 90 && num < 97 {
                num = num%90 + 65
            }
            ch[index] = CChar(num) }
        return String(cString: ch)
    }
    
}
