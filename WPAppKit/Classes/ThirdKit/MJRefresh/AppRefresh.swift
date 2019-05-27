//
//  AppRefresh.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/28.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

public class RefreshHeader: MJRefreshNormalHeader {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setTitle("下拉刷新数据", for: .idle)
        self.setTitle("松开加载", for: .pulling)
        self.setTitle("正在努力加载中", for: .refreshing)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


public class RefreshFooter: MJRefreshBackNormalFooter {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setTitle("上拉加载更多数据", for: .idle)
        self.setTitle("松开加载", for: .pulling)
        self.setTitle("正在努力加载中", for: .refreshing)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
