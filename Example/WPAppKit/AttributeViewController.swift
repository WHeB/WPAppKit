//
//  AttributeViewController.swift
//  WPAppKit_Example
//
//  Created by 王鹏 on 2019/8/19.
//  Copyright © 2019年 CocoaPods. All rights reserved.
//

import UIKit

class AttributeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let label = UILabel(txtColor: UIColor.red, font: UIFont.systemFont(ofSize: 15))
        self.view.addSubview(label)
        label.frame = CGRect(x: 20, y: 100, width: 300, height: 50)
        let origin = "窗前明月光,明月照沟渠"
        
        let attString = NSAttributedString.setBaseAttributToString(original: origin, target: "明月", font: UIFont.systemFont(ofSize: 30), textColor: UIColor.black)
        
//        label.attributedText = attString
        
        
    
        
        
    }
    
}
