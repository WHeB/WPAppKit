//
//  +Bool.swift
//  WPAppKit
//
//  Created by 王鹏 on 2020/7/16.
//

import UIKit

public extension Bool {
    
    var int: Int {
        return self ? 1 : 0
    }
    
    var string: String {
        return self ? "true" : "false"
    }
    
    var ocString: String {
        return self ? "yes" : "no"
    }
    
}
