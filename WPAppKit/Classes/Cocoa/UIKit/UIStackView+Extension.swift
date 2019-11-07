//
//  UIStackView+Extension.swift
//  HBDNavigationBar
//
//  Created by 王鹏 on 2019/11/7.
//

import UIKit

@available(iOS 9.0, *)
public extension UIStackView {
    
    convenience init(distribution: UIStackViewDistribution,
                            alignment: UIStackViewAlignment,
                            axis: UILayoutConstraintAxis,
                            spacing: CGFloat = 0) {
        self.init()
        self.distribution = distribution
        self.alignment = alignment
        self.axis = axis
        self.spacing = spacing
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
