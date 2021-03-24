//
//  TextCarouselView.swift
//  HBDNavigationBar
//
//  Created by 王鹏 on 2019/10/30.
//
//  文字型轮播图  待完善

import UIKit

enum CarouselDirection {
    // top bottom 上下轮播
    case top
    case bottom
    // left right 跑马灯效果
    case left
    case right
}

struct CarouseStyle {
    
    // 轮播方向
    public var scrollerDirection: CarouselDirection = .top
    // 停留时间
    public var time: CGFloat = 2.0
    // 
    
    // 文字颜色
    public var txtColor: UIColor = UIColor.black
    // 文字字号
    public var txtFont: UIFont = UIFont.systemFont(ofSize: 15)
    // 文字方向 .top .bottom 有效
    public var txtAlignment: NSTextAlignment = .left
    // 边距
    public var margin: CGFloat = 15
    // 间距 .left .right 有效
    public var spacing: CGFloat = 20
    
}

public class TextCarouselView: UIView {
    
    private var style: CarouseStyle = CarouseStyle()
    private var timer: Timer!
    
    private var label_1: UILabel!
    private var label_2: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        
        label_1 = UILabel()
        label_1.textColor = self.style.txtColor
        label_1.font = self.style.txtFont
        label_1.textAlignment = self.style.txtAlignment
        self.addSubview(label_1)
        
        label_2 = UILabel()
        label_2.textColor = self.style.txtColor
        label_2.font = self.style.txtFont
        label_2.textAlignment = self.style.txtAlignment
        self.addSubview(label_2)
        
        label_1.text = "1111111111111111111"
        label_1.frame = CGRect(x: 10, y: 0, width: 400, height: 40)
        
        label_2.text = "2222222222222222222"
        label_2.frame = CGRect(x: 10, y: 40, width: 400, height: 40)
        
        self.timer = Timer.init(timeInterval: 3, target: self, selector: #selector(timerRunAction), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var scView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    @objc func timerRunAction() {
        label_2.frame = CGRect(x: 10, y: 40, width: 400, height: 40)
        
        
        
    }
}
