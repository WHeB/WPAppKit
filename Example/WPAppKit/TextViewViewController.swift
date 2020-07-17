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
        
        let redView = UIView(frame: CGRect(x: 50, y: 100, width: 100, height: 20))
        redView.backgroundColor = UIColor.red
        self.view.addSubview(redView)
        
        let textView = UITextView(placeholder: "请输入内容", txtColor: UIColor.black, txtFont: UIFont.systemFont(ofSize: 16))
        textView.frame = CGRect(x: 50, y: 150, width: 100, height: 100)
        textView.backgroundColor = UIColor.orange
        self.view.addSubview(textView)
        
        let priceTextfield = UITextField(placeholder: "请输入价格", txtColor: UIColor.black, txtFont: UIFont.systemFont(ofSize: 18), decimalLength: 8)
        priceTextfield.frame = CGRect(x: 50, y: 260, width: 220, height: 50)
        priceTextfield.backgroundColor = UIColor.yellow
        self.view.addSubview(priceTextfield)
    }
}
