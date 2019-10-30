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
        
        self.setStatus(backgroundColor: UIColor.orange)
        
        self.view.backgroundColor = UIColor.white
        
        self.navigationItem.rightBarButtonItem = self.customImgItem(type: .rightItem, image: UIImage(named: "hud_success")!, imageSize: CGSize(width: 24, height: 24), action: #selector(testAction))
        
        let button = UIButton(title: "你好", txtColor: UIColor.white, font: UIFont.systemFont(ofSize: 14), bgColor: UIColor.white, radius: 20)
        button.frame = CGRect(x: 200, y: 100, width: 80, height: 40)
        self.view.addSubview(button)
        button.setbackground(normalColor: UIColor.orange, selectedColor: UIColor.red)
        button.addTarget(self, action: #selector(buttonAction(button:)), for: .touchUpInside)
        
        let searchView = WPSearchBar(frame: CGRect(x: 20, y: 200, width: ScreenWidth - 40, height: 50))
        searchView.placeholder = "测试一下"
        searchView.searchIcon = UIImage(named: "hud_success")
        self.view.addSubview(searchView)
        
        let tfView = UITextField(frame: CGRect(x: 20, y: 300, width: ScreenWidth - 40, height: 50))
        let leftImg = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        tfView.leftView = leftImg
        tfView.leftViewMode = .always
        tfView.setBorder(color: UIColor.red, borderWidth: 1)
        tfView.placeholder = "测试一下"
        tfView.setPlaceholder(color: UIColor.red)
        self.view.addSubview(tfView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardAction))
        self.view.addGestureRecognizer(tap)
        
        var style = TagStyle()
        style.isMultiSelect = true
        style.tagType = .imgLeft(normalImg: UIImage(named: "normal")!, selectedImg: UIImage(named: "selected")!)
        let tags = TagsView.init(style: style, data: ["香蕉", "橘子", "草莓", "西瓜", "猕猴桃", "火龙果", "榴莲", "芒果", "柚子", "梨", "枣", "草莓", "杏", "很甜很甜的柿子"], frame: CGRect(x: 0, y: 400, width: ScreenWidth, height: 100), result: {(all, indexs, texts) in
            print(all)
            print(indexs)
        })
        tags.backgroundColor = UIColor.yellow
        self.view.addSubview(tags)
        tags.setChooseButton(indexs: [0, 4])
    }
    
    @objc private func hideKeyboardAction() {
        self.view.endEditing(true)
    }
    
    @objc private func buttonAction(button: UIButton) {
        button.isSelected = !button.isSelected
        
        let vc = PresentPopViewViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func testAction() {
        
        
    }
}
