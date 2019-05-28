//
//  DictionaryViewController.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/15.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit
import WPAppKit

class DictionaryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dictionary";
        self.view.backgroundColor = UIColor.white
        
        let pushButton = UIButton.init(title: "push", txtColor: UIColor.red, font: UIFont.systemFont(ofSize: 15))
        pushButton.backgroundColor = UIColor.orange
        pushButton.frame = CGRect.init(x: 30, y: 100, width: 100, height: 40)
        self.view.addSubview(pushButton)
        pushButton.addTarget(self, action: #selector(pushAction), for: .touchUpInside)
        
        var dict = ["name": "张三", "age": "12"]
        let dict2 = ["job": "码农"]
        let ddd = dict.append(dictionary: dict2)
        print(ddd)
        let jsonDict = ddd.toJsonString()
        print(jsonDict)
        print(ddd.toURLParameter())
        let dictResult = jsonDict.toDictionary()
        print("-------\(dictResult)")
    }
    
    @objc private func pushAction() {
//        self.popTo(2)
//        self.popToViewController("StringViewController")
        self.popToController(2)
    }
    
}
