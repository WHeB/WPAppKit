//
//  +UserDefaults.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/8/15.
//

import UIKit

public extension UserDefaults {
    
    /// 快速缓存
    func setObject<T: Encodable>(_ value: T?, forKey defaultName: String) {
        let encoder = PropertyListEncoder()
        let data = (try? value.map {
            try encoder.encode($0)
            }) ?? nil
        self.set(data, forKey: defaultName)
        self.synchronize()
    }
    
    /// 快速解缓存
    func object<T: Decodable>(forKey defaultName: String) -> T? {
        let data = self.data(forKey: defaultName)
        let decoder = PropertyListDecoder()
        let value = (try? data.map {
            try decoder.decode(T.self, from: $0)
            }) ?? nil
        return value
    }
}
