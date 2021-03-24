//
//  +UIBezierPath.swift
//  WPAppKit
//
//  Created by 王鹏 on 2020/7/16.
//

import UIKit

public extension UIBezierPath {
    
    /// 一条线
    convenience init(from: CGPoint, to otherPoint: CGPoint) {
        self.init()
        move(to: from)
        addLine(to: otherPoint)
    }
    
    convenience init(points: [CGPoint]) {
        self.init()
        if !points.isEmpty {
            move(to: points[0])
            for point in points[1...] {
                addLine(to: point)
            }
        }
    }
    
    /// 多边形范围
    convenience init?(polygonWithPoints points: [CGPoint]) {
        guard points.count > 2 else {return nil}
        self.init()
        move(to: points[0])
        for point in points[1...] {
            addLine(to: point)
        }
        close()
    }
    
    /// 固定大小的椭圆路径
    
    /// 固定大小的椭圆路径
    /// - Parameters:
    ///   - size: 椭圆大小
    ///   - centered: 是否居中
    convenience init(ovalOf size: CGSize, centered: Bool) {
        let origin = centered ? CGPoint(x: -size.width / 2, y: -size.height / 2) : .zero
        self.init(ovalIn: CGRect(origin: origin, size: size))
    }
    
    
    /// 固定大小的矩形
    /// - Parameters:
    ///   - size: 矩形大小
    ///   - centered: 是否居中
    convenience init(rectOf size: CGSize, centered: Bool) {
        let origin = centered ? CGPoint(x: -size.width / 2, y: -size.height / 2) : .zero
        self.init(rect: CGRect(origin: origin, size: size))
    }
    
    
    
    
    
    
}
