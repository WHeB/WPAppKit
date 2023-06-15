//
//  +UIScrollView.swift
//  WPAppKit
//
//  Created by 王鹏 on 2020/7/16.
//

import UIKit

public extension UIScrollView {
    
    /// SwifterSwift: Takes a snapshot of an entire ScrollView
    ///
    ///    AnySubclassOfUIScroolView().snapshot
    ///    UITableView().snapshot
    ///
    /// - Returns: Snapshot as UIimage for rendered ScrollView
    var snapshot: UIImage? {
        // Original Source: https://gist.github.com/thestoics/1204051
        UIGraphicsBeginImageContextWithOptions(contentSize, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let previousFrame = frame
        frame = CGRect(origin: frame.origin, size: contentSize)
        layer.render(in: context)
        frame = previousFrame
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// 滚动到底部
    func scrollToBottom(animated: Bool? = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated ?? true)
    }
    
    /// 滚动到顶部
    func scrollToTop(animated: Bool? = true) {
        setContentOffset(CGPoint.zero, animated: animated ?? true)
    }
    
}
