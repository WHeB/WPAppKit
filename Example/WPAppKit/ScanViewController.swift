//
//  ScanViewController.swift
//  WPAppKit_Example
//
//  Created by 王鹏 on 2019/8/2.
//  Copyright © 2019年 CocoaPods. All rights reserved.
//

import UIKit

class ScanViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        
        self.view.addSubview(scanView)
    }
    
    lazy var scanView: QRScanView = {
        let view = QRScanView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        return view
    }()
    
}
