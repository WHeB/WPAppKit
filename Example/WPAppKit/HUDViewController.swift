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
//        AppHud.showGifLoading("loading", maskingAlpha: 0.30)
//        AppHud.showLoading(maskingAlpha: 0.03)
        
        let array = [UIImage(named: "0"),
                     UIImage(named: "1"),
                     UIImage(named: "2"),
                     UIImage(named: "3"),
                     UIImage(named: "4"),
                     UIImage(named: "5"),
                     UIImage(named: "6"),
                     UIImage(named: "7"),
                     UIImage(named: "8"),
                     UIImage(named: "9"),
                     UIImage(named: "10"),
                     UIImage(named: "11")]
        AppHud.showGifLoading(images: array as! [UIImage], maskingAlpha: 0.03)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            AppHud.hideHudView()
        }
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
