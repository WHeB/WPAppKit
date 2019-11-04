//
//  TagsView.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/9/17.
//

import UIKit

public enum TagType {
    case normal     // 默认纯文本
    case imgLeft(normalImg: UIImage, selectedImg: UIImage)    // 左侧图片
    case imgRight(normalImg: UIImage, selectedImg: UIImage)   // 右侧图片
}

public struct TagStyle {
    // 小标签样式
    public var tagType: TagType = .normal
    // 标签背景色
    public var normalBgColor: UIColor = UIColor.white
    public var selectedBgColor: UIColor = UIColor.orange
    // 标签圆角
    public var cornerRadius: CGFloat = 5
    // 边框颜色
    public var borderColor: UIColor = UIColor.orange
    // 边框
    public var borderWidth: CGFloat = 1
    // 字号
    public var txtFont: UIFont = UIFont.systemFont(ofSize: 14)
    // 字体颜色
    public var normalTxtColor: UIColor = UIColor.black
    public var selectedTxtColor: UIColor = UIColor.white
    // x轴方向内边距
    public var itemPaddingX: CGFloat = 5
    // 单个标签高度
    public var itemHeight: CGFloat = 30
    // 行间距
    public var rowSpace: CGFloat = 15
    // 列间距
    public var lineSpace: CGFloat = 15
    // 边距
    public var margin: CGFloat = 25
    // 图文间距 默认5
    public var imgTxtSpace: CGFloat = 5
    // 是否能点击
    public var isClick: Bool = true
    // 是否可以多选
    public var isMultiSelect: Bool = true
    
    public init() {}
}

// 回调
public typealias TagsResultCallBack = (_ result: [(Int, String)], _ index: [Int], _ text: [String]) -> Void

public class TagsView: UIView {
    
    private var data = [String]()
    private var style = TagStyle()
    private var buttons = [UIButton]()
    private var lastChooseIndex = 0 // 最后一个选中的下标
    private var selfHeight: CGFloat = 0 // view高度
    private var chooseResult: TagsResultCallBack?
    private var result = [(Int, String)]()
    private var resultText = [String]()
    private var resultIndex = [Int]()
    
    /// 设置选中
    // indexs: 选中的下标。如果不能多选，只会取第一个。
    public func setChooseButton(indexs: [Int]) {
        if !self.style.isClick || indexs.count == 0 {    // 不能点击
            return
        }
        if self.style.isMultiSelect {   // 可以多选
            for index in indexs {
                let tag = index + 100
                if let btn = self.viewWithTag(tag) as? UIButton {
                    btn.isSelected = true
                }
                // 添加到数组
                self.resultAddRemove(index: index)
            }
        }else {
            let index = indexs.first ?? 0
            let tag = index + 100
            if let btn = self.viewWithTag(tag) as? UIButton {
                btn.isSelected = true
            }
            self.lastChooseIndex = tag
            // 添加到数组
            self.resultAddRemove(index: index)
        }
        // 回调
        self.chooseResult?(result, resultIndex, resultText)
    }
    
    /// 重置数据源
    // 注意:重置数据源后，以前选中状态会被清除
    public func refreshData(data: [String]) {
        if self.data == data {
            return
        }
        for sub in self.subviews {
            sub.removeFromSuperview()
        }
        self.data = data
        loadSubView()
        // 重置高度
        self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: self.selfHeight)
        
        self.result.removeAll()
        self.resultIndex.removeAll()
        self.resultText.removeAll()
    }
    
    /// 实例化
    public convenience init(style: TagStyle, data: [String], frame: CGRect, result: @escaping TagsResultCallBack) {
        self.init(frame: frame)
        self.style = style
        self.data = data
        loadSubView()
        self.chooseResult = result
        // 重置高度
        self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: self.selfHeight)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func loadSubView() {
        if data.count == 0 {
            return
        }
        
        var btnX: CGFloat = self.style.margin
        var btnY: CGFloat = self.style.rowSpace
        
        for (index, text) in self.data.enumerated() {
            let button = self.getButton(title: text)

            let btnW = self.getButtonWidth(text: text, button: button)
            let btnH = self.style.itemHeight
            if btnX + btnW + self.style.lineSpace + self.style.margin > self.width { // 换行
                btnX = self.style.margin
                btnY += (btnH + self.style.rowSpace)
                button.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
            }else {
                button.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
            }
            btnX += (btnW + self.style.lineSpace)
            // view的高度
            selfHeight = button.bottomY + self.style.rowSpace
            
            switch self.style.tagType {
                case .normal:
                    break
                case .imgLeft:
                    button.setImageOrientation(position: .left, spacing: self.style.imgTxtSpace)
                case .imgRight:
                    button.setImageOrientation(position: .right, spacing: self.style.imgTxtSpace)
            }
            button.setbackground(normalColor: self.style.normalBgColor, selectedColor: self.style.selectedBgColor)
            button.setCornerRadiusAndBorder(.allCorners,
                                            cornerRadius: self.style.cornerRadius,
                                            color: self.style.borderColor,
                                            borderWidth: self.style.borderWidth)
            button.tag = index + 100 // 防止 viewWithTag 出错
            button.addTarget(self, action: #selector(chooseAction(button:)), for: .touchUpInside)
            self.addSubview(button)
        }
    }
    
    private func getButton(title: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.adjustsImageWhenHighlighted = false
        button.titleLabel?.font = self.style.txtFont
        button.setTitle(title, for: .normal)
        button.setTitleColor(self.style.normalTxtColor, for: .normal)
        button.setTitle(title, for: .selected)
        button.setTitleColor(self.style.selectedTxtColor, for: .selected)
        
        switch self.style.tagType {
        case .normal:
            break
        case .imgLeft(let normalImg, let selectedImg):
            button.setImage(normalImg, for: .normal)
            button.setImage(selectedImg, for: .selected)
        case .imgRight(let normalImg, let selectedImg):
            button.setImage(normalImg, for: .normal)
            button.setImage(selectedImg, for: .selected)
        }
        return button
    }
    
    private func getButtonWidth(text: String, button: UIButton) -> CGFloat {
        switch self.style.tagType {
        case .normal:
            let txtW = text.txtStringWidth(font: self.style.txtFont, maxHeight: self.style.itemHeight)
            return txtW + (self.style.itemPaddingX + self.style.cornerRadius) * CGFloat(2.0)
        case .imgLeft, .imgRight:
            let txtW = text.txtStringWidth(font: self.style.txtFont, maxHeight: self.style.itemHeight)
            // self.style.txtFont.pointSize + 4 为字号大小
            let imgW = button.imageView?.image?.size.width ?? 18
            return txtW + (self.style.itemPaddingX + self.style.cornerRadius) * CGFloat(2.0) + self.style.imgTxtSpace + imgW
        }
    }
    
    @objc private func chooseAction(button: UIButton) {
        if !self.style.isClick {    // 不能点击
            return
        }
        if self.style.isMultiSelect {   // 可以多选
            button.isSelected = !button.isSelected
        }else {
            if let lastBtn = self.viewWithTag(self.lastChooseIndex) as? UIButton {
                lastBtn.isSelected = false
            }
            button.isSelected = true
            self.lastChooseIndex = button.tag
        }
        // 添加到数组
        self.resultAddRemove(index: button.tag - 100)
        // 回调
        self.chooseResult?(result, resultIndex, resultText)
    }
    
    // 添加和删除元素
    private func resultAddRemove(index: Int) {
        if index > data.count {
            return
        }
        let text = self.data[index]
        let indexText = (index, text)
        
        if !self.style.isMultiSelect { // 单选
            self.result.removeAll()
            self.resultText.removeAll()
            self.resultIndex.removeAll()
            
            self.result.append(indexText)
            self.resultText.append(text)
            self.resultIndex.append(index)
            return
        }
        
        // 多选
        let isContains = self.result.contains {
            return $0 == indexText
        }
        if isContains {
            self.result = self.result.filter {
                return $0 != indexText
            }
            self.resultText = self.resultText.filter {
                return $0 != text
            }
            self.resultIndex = self.resultIndex.filter {
                return $0 != index
            }
        }else {
            self.result.append(indexText)
            self.resultText.append(text)
            self.resultIndex.append(index)
        }
    }
}
