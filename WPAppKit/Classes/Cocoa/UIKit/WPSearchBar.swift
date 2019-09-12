//
//  WPSearchBar.swift
//  Alamofire
//
//  Created by 王鹏 on 2019/9/3.
//

import UIKit

public class WPSearchBar: UISearchBar, UITextFieldDelegate {
    
    public var font: UIFont? {
        didSet {
            guard let tfSearch = self.searchTextField else {
                return
            }
            tfSearch.font = font
            placeholderSize = (self.placeholder as NSString?)?.size(withAttributes: [NSAttributedStringKey.font : font ?? 15]) ?? .zero
            
            setNormalPosition()
        }
    }
    
    public var textColor: UIColor? {
        didSet {
            guard let tfSearch = self.searchTextField else {
                return
            }
            tfSearch.textColor = textColor
        }
    }
    
    override public var placeholder: String? {
        didSet {
            guard let tfSearch = self.searchTextField else {
                return
            }
            placeholderSize = (self.placeholder as NSString?)?.size(withAttributes: [NSAttributedStringKey.font : tfSearch.font ?? 15]) ?? .zero
            
            setNormalPosition()
        }
    }
    
    public var searchIcon: UIImage? {
        didSet {
            searchIconSize = searchIcon?.size ?? CGSize(width: 14, height: 14)
            self.setImage(searchIcon, for: .search, state: .normal)
            
            setNormalPosition()
        }
    }
    
    private var searchTextField: UITextField?
    private var placeholderSize = CGSize.zero
    private var searchIconSize = CGSize(width: 14, height: 14)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.placeholder = "搜索"
        
        if let tfSearch: UITextField = self.value(forKey: "searchField") as? UITextField {
            self.searchTextField = tfSearch
            tfSearch.font = UIFont.systemFont(ofSize: 15)
            
            placeholderSize = (self.placeholder as NSString?)?.size(withAttributes: [NSAttributedStringKey.font : tfSearch.font ?? 15]) ?? .zero
        }
        setNormalPosition()
    }
    
    // 设置初始化偏移
    private func setNormalPosition() {
        if #available(iOS 11.0, *) {
            self.setPositionAdjustment(UIOffset.init(horizontal: (self.width - (self.searchIconSize.width + 8 + 30 +  self.placeholderSize.width)) / 2, vertical: 0), for: .search)
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
                self.setPositionAdjustment(UIOffset.init(horizontal: (self.width - (self.searchIconSize.width + 13 + self.placeholderSize.width)) / 2, vertical: 0), for: .search)
            }
        }
        return true
    }
    
    override public func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let isInside = super.point(inside: point, with: event)
        if isInside == false {
            self.searchTextField?.resignFirstResponder()
        }
        return isInside
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
