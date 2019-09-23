//
//  UIViewViewController.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/16.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit
import WPAppKit

class UIViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.navigationItem.rightBarButtonItem = self.customImgItem(type: .rightItem, image: UIImage(named: "hud_success")!, imageSize: CGSize(width: 24, height: 24), action: #selector(testAction))
        
        let button = UIButton(title: "你好", txtColor: UIColor.white, font: UIFont.systemFont(ofSize: 14), bgColor: UIColor.white, radius: 20)
        button.frame = CGRect(x: 200, y: 100, width: 80, height: 40)
        self.view.addSubview(button)
        button.setbackground(normalColor: UIColor.orange, selectedColor: UIColor.red)
        button.addTarget(self, action: #selector(buttonAction(button:)), for: .touchUpInside)
        
        let line = UILabel(lineBgColor: UIColor.red)
        line.frame = CGRect(x: ScreenWidth / 2 - 0.5, y: 180, width: 1, height: 20)
        self.view.addSubview(line)
        
        let searchView = WPSearchBar(frame: CGRect(x: 20, y: 200, width: ScreenWidth - 40, height: 50))
        searchView.placeholder = "测试一下"
        searchView.searchIcon = UIImage(named: "hud_success")
        self.view.addSubview(searchView)
        
        let tfView = UITextField(frame: CGRect(x: 20, y: 300, width: ScreenWidth - 40, height: 50))
        tfView.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        tfView.leftViewMode = .always
        tfView.setBorder(color: UIColor.red, borderWidth: 1)
        tfView.placeholder = "测试一下"
        tfView.setPlaceholder(color: UIColor.red)
        self.view.addSubview(tfView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardAction))
        self.view.addGestureRecognizer(tap)
        
    }
    
    @objc private func hideKeyboardAction() {
        self.view.endEditing(true)
    }
    
    @objc private func buttonAction(button: UIButton) {
        button.isSelected = !button.isSelected
    }
    
    @objc private func testAction() {
        
        
    }
}
