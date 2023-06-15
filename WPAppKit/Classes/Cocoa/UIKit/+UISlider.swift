//
//  +UISlider.swift
//  WPAppKit
//
//  Created by 王鹏 on 2020/7/16.
//

import UIKit

public extension UISlider {
    
    convenience init(minTrackColor: UIColor,
                     maxTrackColor: UIColor,
                     minValue: Float,
                     maxValue: Float,
                     normalValue: Float? = 0,
                     target: AnyObject,
                     action: Selector) {
        self.init()
        self.minimumTrackTintColor = minTrackColor
        self.maximumTrackTintColor = maxTrackColor
        self.minimumValue = minValue
        self.maximumValue = maxValue
        self.value = normalValue ?? maxValue/2.0
        //设置在停止滑动时才出发响应事件
        self.isContinuous = false
        self.addTarget(target, action: action, for: .valueChanged)
    }
    
    convenience init(minTrackColor: UIColor,
                     maxTrackColor: UIColor,
                     minValue: Float,
                     maxValue: Float,
                     normalValue: Float? = 0,
                     minValueImage: UIImage,
                     maxValueImage: UIImage,
                     target: AnyObject,
                     action: Selector) {
        self.init()
        self.minimumTrackTintColor = minTrackColor
        self.maximumTrackTintColor = maxTrackColor
        self.minimumValue = minValue
        self.maximumValue = maxValue
        self.value = normalValue ?? maxValue/2.0
        self.minimumValueImage = minValueImage
        self.maximumValueImage = maxValueImage
        //设置在停止滑动时才出发响应事件
        self.isContinuous = false
        self.addTarget(target, action: action, for: .valueChanged)
    }
    
    func setValue(value: Float,
                  animated: Bool = true,
                  duration: TimeInterval = 1,
                  completion: (() -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: duration, animations: {
                self.setValue(value, animated: true)
            }, completion: { _ in
                completion?()
            })
        } else {
            setValue(value, animated: false)
            completion?()
        }
    }
    
}
