//
//  TableViewController.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/18.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit
import WPAppKit

@available(iOS 9.0, *)
class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)
    }

    lazy var tableView: UITableView = {
        let view = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 64), style: .plain)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
    
}

