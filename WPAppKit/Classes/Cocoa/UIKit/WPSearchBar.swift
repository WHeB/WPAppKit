//
//  WPSearchBar.swift
//  Alamofire
//
//  Created by 王鹏 on 2019/9/3.
//

import UIKit

/*
 遵守代理 实现这两个方法即可
 func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
 func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
 */

public class WPSearchBar: UISearchBar, UITextFieldDelegate {
    
    /// 输入框
    public var searchField: UITextField? {
        get {
            self.layoutIfNeeded() // 需要获取frame
            if #available(iOS 13.0, *) {
                return self.searchTextField
            }else {
                if let tfSearch: UITextField = self.value(forKey: "searchField") as? UITextField {
                    return tfSearch
                }
            }
            return nil
        }
    }
    
    /// 输入框字号
    public var font: UIFont? {
        didSet {
            guard let tfSearch = self.searchField else {
                return
            }
            tfSearch.font = font
            placeholderSize = (self.placeholder as NSString?)?.size(withAttributes: [NSAttributedStringKey.font : font ?? 15]) ?? .zero
            
            setNormalPosition()
        }
    }
    
    /// 输入框字体颜色
    public var textColor: UIColor? {
        didSet {
            guard let tfSearch = self.searchField else {
                return
            }
            tfSearch.textColor = textColor
        }
    }
    
    /// placeholder
    override public var placeholder: String? {
        didSet {
            guard let tfSearch = self.searchField else {
                return
            }
            placeholderSize = (self.placeholder as NSString?)?.size(withAttributes: [NSAttributedStringKey.font : tfSearch.font ?? 15]) ?? .zero
            setNormalPosition()
        }
    }
    
    /// 搜索框图标
    public var searchIcon: UIImage? {
        didSet {
            searchIconSize = searchIcon?.size ?? CGSize(width: 14, height: 14)
            self.setImage(searchIcon, for: .search, state: .normal)
            
            setNormalPosition()
        }
    }
    
    /// 搜索框背景颜色
    override public var backgroundColor: UIColor? {
        didSet {
            if let color = backgroundColor {
                self.backgroundImage = UIImage.colorToImage(color)
            }
        }
    }
    
    /// 是否居中
    public var isCenterAlignment: Bool? {
        didSet {
            self.isCenterAli = isCenterAlignment ?? true
            setNormalPosition()
        }
    }
    
    private var placeholderSize = CGSize.zero
    private var searchIconSize = CGSize(width: 14, height: 14)
    private var isCenterAli = true
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.placeholder = "搜索"
        
        if #available(iOS 13.0, *) {
            let tfSearch = self.searchTextField
            tfSearch.delegate = self
            tfSearch.font = UIFont.systemFont(ofSize: 15)
            placeholderSize = (self.placeholder as NSString?)?.size(withAttributes: [NSAttributedStringKey.font : tfSearch.font ?? 15]) ?? .zero
        }else {
            if let tfSearch: UITextField = self.value(forKey: "searchField") as? UITextField {
                tfSearch.font = UIFont.systemFont(ofSize: 15)
                placeholderSize = (self.placeholder as NSString?)?.size(withAttributes: [NSAttributedStringKey.font : tfSearch.font ?? 15]) ?? .zero
            }
        }
        setNormalPosition()
    }
    
    // 设置初始化偏移
    private func setNormalPosition() {
        if !isCenterAli {
            self.setPositionAdjustment(UIOffset.init(horizontal: 0, vertical: 0), for: .search)
            return
        }
        if #available(iOS 11.0, *) {
            let offX = (self.width - (self.searchIconSize.width + 8 + 30 +  self.placeholderSize.width)) / 2
            self.setPositionAdjustment(UIOffset.init(horizontal: offX, vertical: 0), for: .search)
        }
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if #available(iOS 11.0, *) {
            UIView.animate(withDuration: 0.25) {
                self.setPositionAdjustment(UIOffset.zero, for: .search)
            }
        }
        return true
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let text = textField.text, text.count > 0 { // 有文字就不删除
            return true
        }
        if #available(iOS 11.0, *) {
            UIView.animate(withDuration: 0.25) {
                self.setNormalPosition()
            }
        }
        return true
    }
    
    override public func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let isInside = super.point(inside: point, with: event)
        if isInside == false {
            self.resignFirstResponder()
        }
        return isInside
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
