//
//  CarouseViewController.swift
//  WPAppKit_Example
//
//  Created by 王鹏 on 2019/10/31.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import WPAppKit

class CarouseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        adView1.frame = CGRect(x: 0, y: 100, width: ScreenWidth, height: 50)
        self.view.addSubview(adView1)
    }
    
    
    lazy var adView1: TextCarouselView = {
        let view = TextCarouselView()
        return view
    }()
    
}
