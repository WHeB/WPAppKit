//
//  TagsViewController.swift
//  WPAppKit_Example
//
//  Created by 王鹏 on 2019/10/31.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import WPAppKit

class TagsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(scView)
        
        let dataArray = ["草莓", "西瓜", "猕猴桃", "火龙果", "榴莲", "芒果", "柚子", "梨", "枣", "草莓", "杏", "很甜很甜的柿子", "香蕉", "橘子", "草莓", "西瓜", "猕猴桃", "火龙果", "榴莲", "芒果", "柚子", "梨", "枣", "草莓", "杏", "很甜很甜的柿子", "香蕉", "橘子", "枇杷", "西瓜", "猕猴桃", "火龙果", "榴莲", "芒果", "柚子", "梨", "枣", "草莓", "杏", "柿子", "香蕉", "柚子", "橙子", "柚子", "梨", "枣", "草莓", "杏", "很甜很甜的柿子", "香蕉", "橘子", "枇杷", "西瓜", "猕猴桃", "火龙果", "榴莲", "芒果", "柚子", "梨", "枣", "草莓", "杏", "很甜很甜的柿子", "香蕉", "橘子", "枇杷", "西瓜", "西瓜", "猕猴桃", "火龙果", "榴莲", "芒果", "柚子", "梨", "枣", "草莓", "杏", "很甜很甜的柿子", "香蕉", "橘子", "枇杷", "西瓜", "猕猴桃", "火龙果", "榴莲", "芒果", "柚子", "梨", "枣", "草莓", "杏", "柿子", "香蕉", "柚子", "橙子", "柚子", "梨", "枣"]
        
        var style = TagStyle()
        style.isMultiSelect = true
        style.tagType = .imgLeft(normalImg: UIImage(named: "normal")!, selectedImg: UIImage(named: "selected")!)
        let tags = TagsView.init(style: style, data: dataArray, frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 100), result: {(all, indexs, texts) in
            print(all)
            print(indexs)
        })
        tags.backgroundColor = UIColor.yellow
        scView.addSubview(tags)
        tags.setChooseButton(indexs: [0, 4])
        
        scView.contentSize = CGSize(width: ScreenWidth, height: tags.height)
    }
    
    lazy var scView: UIScrollView = {
        let view = UIScrollView(frame: CGRect(x: 0, y: DeviceInfo.headerBarHeight, width: ScreenWidth, height: DeviceInfo.withoutHeaderBar))
        return view
    }()
    
}
