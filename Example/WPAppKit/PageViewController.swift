//
//  PageViewController.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/18.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

class PageViewController: UIViewController, UIScrollViewDelegate {

    private var lastY: CGFloat = 0
    private var navBarH: CGFloat = 64
    private var oneVC: TableViewController!
    private var twoVC: TableViewController!
    private var tableviewArray = [UITableView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.addSubview(boxScrollerView)
        self.view.addSubview(headView)
        
        lastY = -headView.bounds.size.height
        
        oneVC = TableViewController()
        self.addChild(oneVC)
        boxScrollerView.addSubview(oneVC.view)
        oneVC.view.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: boxScrollerView.bounds.size.height)
        oneVC.tableView.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0)
        oneVC.tableView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        
        twoVC = TableViewController()
        self.addChild(twoVC)
        boxScrollerView.addSubview(twoVC.view)
        twoVC.view.frame = CGRect.init(x: ScreenWidth, y: 0, width: ScreenWidth, height: boxScrollerView.bounds.size.height)
        twoVC.tableView.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0)
        twoVC.tableView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        
        self.tableviewArray = [oneVC.tableView, twoVC.tableView]
    }
    
    lazy var boxScrollerView: UIScrollView = {
        let view = UIScrollView.init(frame: CGRect.init(x: 0, y: navBarH, width: ScreenWidth, height: ScreenHeight - navBarH))
        view.contentSize = CGSize.init(width: ScreenWidth * 2, height: ScreenHeight - navBarH)
        view.isPagingEnabled = true
        view.delegate = self
        return view
    }()
    
    lazy var headView: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: navBarH, width: ScreenWidth, height: 200))
        view.backgroundColor = UIColor.red
        return view
    }()
    
     override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let tableView = object as? UITableView else {
            return
        }
        let offset = tableView.contentOffset.y
        let delta = offset - self.lastY
        
        if offset >= -200 && offset <= 0 {
            self.headView.frame.origin.y = navBarH - delta
            self.tableviewArray.forEach {
                var contentOffset = $0.contentOffset
                contentOffset.y = offset
                if $0.contentOffset.y != contentOffset.y {
                    $0.contentOffset = contentOffset
                }
            }
//            if abs(self.headView.frame.origin.y - navBarH) < 10 {
//                self.headView.frame.origin.y = navBarH
//            }
        }
        
        if delta > 190 {
            self.headView.frame.origin.y = navBarH - 200
        }
        if delta < 10 {
            self.headView.frame.origin.y = navBarH
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        
    }
    
}
