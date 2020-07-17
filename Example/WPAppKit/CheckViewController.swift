//
//  CheckViewController.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/15.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit
import WPAppKit

class CheckViewController: UIViewController {
    
    private var textField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let url = "https://www.baidu.com/s?wd=%E8%A7%86%E9%A2%91%E5%AA%92%E4%BD%93%E6%A0%BC%E5%BC%8F&pn=10&oq=%E8%A7%86%E9%A2%91%E5%AA%92%E4%BD%93%E6%A0%BC%E5%BC%8F&tn=baiduhome_pg&ie=utf-8&usm=1&rsv_idx=2&rsv_pq=b9d7b6c00010cee6&rsv_t=aa1f%2BgCvMO7Axvm0q%2FQ2TZrOfoksw%2Bx%2F4v2yGB0R1FfsznsQiURXp9dM%2FcjqPVeVs1XE"
        let dict = url.urlStringToDict()
        print(dict)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
    }
}
