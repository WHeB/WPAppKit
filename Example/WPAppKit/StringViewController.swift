//
//  StringViewController.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/15.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit
import WPAppKit

class StringViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "String"
        self.view.backgroundColor = UIColor.white
        
        let pushButton = UIButton.init(title: "push", txtColor: UIColor.red, font: UIFont.systemFont(ofSize: 15))
        pushButton.backgroundColor = UIColor.orange
        pushButton.frame = CGRect.init(x: 30, y: 100, width: 100, height: 40)
        self.view.addSubview(pushButton)
        pushButton.addTarget(self, action: #selector(pushAction), for: .touchUpInside)
        
        print(RandomTool.randomString(length: 10))
        print(RandomTool.randomString(length: 30, isLetter: true))
        
        let sss = "12你aa"
        print(sss.charLength())
    }
    
    @objc private func pushAction() {
        self.push(viewController: ArrayViewController())
    }
    
}
