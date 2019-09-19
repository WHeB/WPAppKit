//
//  HUDViewController.swift
//  WPAppKit_Example
//
//  Created by 王鹏 on 2019/7/4.
//  Copyright © 2019年 CocoaPods. All rights reserved.
//

import UIKit
import WPAppKit

class HUDViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        AppHud.showLoading()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppHud.hideHudView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let button = UIButton(title: "alert", txtColor: UIColor.red, font: UIFont.systemFont(ofSize: 14))
        button.frame = CGRect(x: 50, y: 100, width: 100, height: 40)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(showAction), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc private func showAction() {
        
    }
}
