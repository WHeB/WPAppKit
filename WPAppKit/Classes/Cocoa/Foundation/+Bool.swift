//
//  +Bool.swift
//  WPAppKit
//
//  Created by 王鹏 on 2020/7/16.
//

import UIKit

public extension Bool {
    
    var toInt: Int {
        return self ? 1 : 0
    }
    
    var toString: String {
        return self ? "true" : "false"
    }
    
    var toOCString: String {
        return self ? "yes" : "no"
    }
    
}
