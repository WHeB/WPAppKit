//
//  PhotoViewController.swift
//  WPAppKit_Example
//
//  Created by 王鹏 on 2019/11/8.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import WPAppKit

class PhotoViewController: UIViewController {

    private var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.imageView = UIImageView(frame: CGRect(x: ScreenWidth/2 - 50, y: 100, width: 100, height: 100))
        imageView.backgroundColor = UIColor.orange
        self.view.addSubview(imageView)
        
        imageView.addTapGesture(target: self, action: #selector(chooseImgAction))
    }
    
    @objc private func chooseImgAction() {
        var style = WPPopupStyle()
        style.animationOptions = .sheetBottomPop
        WPPopupView.showSheetView(style: style, title: "请选择照片", buttons: ["拍照", "选择照片", "取消"]) { (string, index) in
            let manger = PhotoManger.share
            manger.reduceLevel = 900
            manger.savePhoto = true
            if index == 0 {
                manger.takePhoto()
                
            }else if index == 1 {
                manger.libraryPicker()
            }
            manger.finishBlock = {
                self.imageView.image = $0
                print($1.count / 1024)
            }
            manger.saveBlock = {
                print($0)
            }
        }
    }
    
}
