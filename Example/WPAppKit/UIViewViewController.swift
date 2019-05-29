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

        title = "UIView"
        view.backgroundColor = UIColor.white
        
        let redView = UIView(frame: CGRect.init(x: 30, y: 100, width: 100, height: 100))
        self.view.addSubview(redView)
        redView.setGradientColor(startOrientation: .top, endOrientation: .bottom, colors: [UIColor.red.cgColor, UIColor.purple.cgColor])
        redView.setAllCornerRadius(cornerRadius: 10)
        redView.setBorder(color: UIColor.black, borderWidth: 10)
        
        let imgView = UIImageView.init(frame: CGRect.init(x: 200, y: 100, width: 100, height: 100))
        imgView.image = UIImage.init(named: "img2")
        self.view.addSubview(imgView)
        imgView.setCornerRadius(cornerRadius: 50)
       
        let sssss = "《上邪》是一首乐府民歌，是一首描写爱情的恋歌，是女主人公对于爱情的忠贞不渝的自誓之词。全首词以五种不可能发生的事情来表明自己忠贞不渝的爱情。你我在世间都希望有一份情，是相伴到老，是生死不渝，这样的爱情是一生最美的追求。"
        
        LocalStoreTool.share.writeString(toFilePath: "/string.text", string: sssss)
        let ss = LocalStoreTool.share.documentFileName(fileName: "/string.text")
        print(ss)
        
    }
}
