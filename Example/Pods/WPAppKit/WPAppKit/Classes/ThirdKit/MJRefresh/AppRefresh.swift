//
//  AppRefresh.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/28.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit
import MJRefresh

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


/// git下拉刷新 refreshHeader.gif
public class RefreshGifHeader: MJRefreshGifHeader {
    
    override public func prepare() {
        super.prepare()
        
        guard let imgPath = Bundle.main.path(forResource:"refreshHeader", ofType:"gif") else {
            return
        }
        guard let imgData = NSData(contentsOfFile: imgPath) else {
            return
        }
        guard let imgSource = CGImageSourceCreateWithData(imgData, nil) else {
            return
        }
        let imgCount = CGImageSourceGetCount(imgSource)
        var imgs = [UIImage]()
        for i in 0..<imgCount {
            guard let cgimg = CGImageSourceCreateImageAtIndex(imgSource, i, nil) else { continue }
            let img = UIImage(cgImage: cgimg)
            imgs.append(img)
        }
        
        self.setImages(imgs, for: .idle)
        self.setImages(imgs, for: .pulling)
        self.setImages(imgs, for: .refreshing)
    }
}
