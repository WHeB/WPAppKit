//
//  ViewController.swift
//  WPAppKit
//
//  Created by WHeB on 05/27/2019.
//  Copyright (c) 2019 WHeB. All rights reserved.
//

import UIKit
import WPAppKit

let ScreenWidth: CGFloat = UIScreen.main.bounds.size.width
let ScreenHeight: CGFloat = UIScreen.main.bounds.size.height

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Test"
        self.view.addSubview(self.tableView)
        
        self.navigationItem.rightBarButtonItem = self.customImgItem(type: .rightItem, image: UIImage(named: "hud_success"), action: #selector(clickAction))
    }
    
    @objc private func clickAction() {
          
        
    }
    
    lazy var demoData: [(String, UIViewController)] = {
        let array: [(String, UIViewController)] = [
            ("String", StringViewController()),
            ("Array", ArrayViewController()),
            ("Dictionary", DictionaryViewController()),
            ("ViewController", ViewController()),
            ("ValueCheckTool", CheckViewController()),
            ("UIView", UIViewViewController()),
            ("TextView", TextViewViewController()),
            ("PageView", PageViewController()),
            ("PopView", HomeViewController()),
            ("WebView", WebViewController()),
            ("HUD", HUDViewController()),
            ("标签", TagsViewController()),
            ("轮播", CarouseViewController())]
        return array
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView.init()
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.demoData[indexPath.row].0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = self.demoData[indexPath.row].1
        vc.title = self.demoData[indexPath.row].0
        self.push(viewController: vc)
    }
}

