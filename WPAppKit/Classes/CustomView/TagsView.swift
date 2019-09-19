//
//  TagsView.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/9/17.
//

import UIKit

public struct TagStyle {

    // 标签背景色
    var bgColor: UIColor = UIColor.white
    // 标签选中背景色
    var selectedBgColor: UIColor = UIColor.orange
    // 标签圆角
    var cornerRadius: CGFloat = 5
    // 边框颜色
    var borderColor: UIColor = UIColor.orange
    // 边框
    var borderWidth: CGFloat = 1
    // 字号
    var txtFont: UIFont = UIFont.systemFont(ofSize: 14)
    // 字体颜色
    var txtColor: UIColor = UIColor.black
    // 行间距
    var rowSpace: CGFloat = 15
    // 列间距
    var lineSpace: CGFloat = 20
    // 边距
    var margin: CGFloat = 25
    
}

public class TagsView: UIView {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
