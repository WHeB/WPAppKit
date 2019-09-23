//
//  UIView+Position.swift
//  ShanXiMuseum
//
//  Created by liuyi on 2018/2/9.
//  Copyright © 2018年 liuyi. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    
    //frame.origin.x
    public var ly_left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    //frame.origin.y
    public var ly_top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    //frame.origin.x + frame.size.width
    public var ly_right: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
    }
    
    //frame.origin.y + frame.size.height
    public var ly_bottom: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue - frame.origin.y
            self.frame = frame
        }
    }
    
    //frame.size.width
    public var ly_width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    //frame.size.height
    public var ly_height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    //center.x
    public var ly_centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center = CGPoint.init(x: newValue, y: self.center.y)
        }
    }
    
    //center.y
    public var ly_centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center = CGPoint.init(x: self.center.x, y: newValue)
        }
    }
    
    //frame.origin
    public var ly_origin: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    
    //frame.size
    public var ly_size: CGSize {
        get {
            return self.frame.size
        }
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    
    //maxX
    public var ly_maxX: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
    }
    
    //maxY
    public var ly_maxY: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
    }
    
    
}








