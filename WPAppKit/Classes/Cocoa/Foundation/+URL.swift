//
//  +URL.swift
//  Alamofire
//
//  Created by 王鹏 on 2020/8/25.
//

import UIKit

extension URL {
    
    /// URL参数拼接
    func appendingQueryItem(_ name: String, value: String?) -> URL {
        // 兼容哈希模式 先去掉 /#，再追加参数，再替换回带 /#
        if self.absoluteString.contains("/#") {
            let copyUrlString = self.absoluteString // 先拷贝下来后面需要用
            var tempUrlString = self.absoluteString // 待替换的url
            tempUrlString = tempUrlString.replace(of: "/#", with: "")
            guard let tempUrl = URL(string: tempUrlString) else {
                return self
            }
            var components = URLComponents(url: tempUrl, resolvingAgainstBaseURL: false)
            if components?.queryItems == nil {
                components?.queryItems = []
            }
            components?.queryItems?.append(.init(name: name, value: value))
            guard let resultUrlString = components?.url?.absoluteString.replace(of: tempUrlString, with: copyUrlString) else { return self }
            return URL(string: resultUrlString) ?? self
        }else {
            var components = URLComponents(url: self, resolvingAgainstBaseURL: false)
            if components?.queryItems == nil {
                components?.queryItems = []
            }
            components?.queryItems?.append(.init(name: name, value: value))
            return components?.url ?? self
        }
    }
    
}
