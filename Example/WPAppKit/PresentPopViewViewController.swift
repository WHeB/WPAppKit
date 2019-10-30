//
//  PresentPopViewViewController.swift
//  WPAppKit_Example
//
//  Created by 王鹏 on 2019/9/25.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class PresentPopViewViewController: UIViewController {

    
    private var popView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.3) {
            self.popView.y = ScreenHeight - 300
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.view.backgroundColor = UIColor.white
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        popView = UIView(frame: CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: 300))
//        view.center = CGPoint(x: ScreenWidth / 2, y: ScreenHeight / 2)
        popView.backgroundColor = UIColor.white
        self.view.addSubview(popView)
        
        let button = UIButton(title: "取消", txtColor: UIColor.red, font: UIFont.systemFont(ofSize: 15))
        button.frame = CGRect(x: 20, y: 20, width: 50, height: 30)
        button.addTarget(self, action: #selector(cancleAction), for: .touchUpInside)
        popView.addSubview(button)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(cancleAction))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func cancleAction() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.popView.y = ScreenHeight
        }) { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }

}
