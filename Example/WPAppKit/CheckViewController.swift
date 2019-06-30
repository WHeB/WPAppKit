//
//  CheckViewController.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/15.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit
import WPAppKit

class CheckViewController: UIViewController {

    private var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

        print(ValueCheckTool.checkChinese(string: "123hello"))
        print(ValueCheckTool.checkChinese(string: "hello 中国"))
        
        print("中国欢迎你".transformToPinyin(isBlank: false))
    
        let email = "1193325271@163.com"
        print(ValueCheckTool.checkEmail(email: email))
        
        let psd = "12312sss"
        print(ValueCheckTool.checkPassword(password: psd))
        
    }
}
