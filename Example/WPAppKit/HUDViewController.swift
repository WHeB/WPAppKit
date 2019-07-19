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
        AppHud.showGifLoading("loading")
//        AppHud.showToast("加载中。。。", delay: 100)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppHud.hideHudView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orange
        
//        AppHud.showGifLoading("loading")
    }
}
