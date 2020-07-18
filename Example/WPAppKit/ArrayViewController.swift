//
//  ArrayViewController.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/15.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

class ArrayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Array"
        self.view.backgroundColor = UIColor.white
        
        let pushButton = UIButton.init(title: "push", txtColor: UIColor.red, font: UIFont.systemFont(ofSize: 15))
        pushButton.backgroundColor = UIColor.orange
        pushButton.frame = CGRect.init(x: 30, y: 100, width: 100, height: 40)
        self.view.addSubview(pushButton)
        pushButton.addTarget(self, action: #selector(pushAction), for: .touchUpInside)
        
        var array1 = [12, 12, 2, 34, 33, 45, 66, 77, 124]
        let jsonString = array1.toJsonString()
        print("---jsonString---\(jsonString)")
        
        let array2 = jsonString.toArray()
        print("------\(array2)")
        
        let rest = array1.remove(at: 12)
        print("------\(rest)")
        
        let rest2 = array1.removeAll([12, 2])
        print("------\(rest2)")
        
        UIImageView()
        
    }
    
    @objc private func pushAction() {
        self.pushViewController(DictionaryViewController())
    }
}
