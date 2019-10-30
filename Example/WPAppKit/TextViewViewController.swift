//
//  TextViewViewController.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/15.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit
import SnapKit

class TextViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TextView"
        self.view.backgroundColor = UIColor.white
        
        var textView = UITextView.init(frame: CGRect.init(x: 50, y: 100, width: 200, height: 100))
        self.view.addSubview(textView)
        textView.setBorder(color: UIColor.orange, borderWidth: 2)
        textView.placeholder = "请输入内容"
        textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
}
