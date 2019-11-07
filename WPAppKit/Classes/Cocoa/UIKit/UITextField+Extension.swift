//
//  UITextField+Extension.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/15.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

public enum TxtKeyboardType {
    case normal                 // 默认 支持所有字符
    case number                 // 纯数字
    case price                  // 价格 小数点后两位
    case password               // 密码
    case url                    // URL键盘，有.com按钮
    case email                  // 邮箱
}


public extension UITextField {
    
    /// 设置 Placeholder 颜色
    func setPlaceholder(color: UIColor) {
        guard let placeholder = self.placeholder else {
            return
        }
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedStringKey.foregroundColor : color])
    }
    
    /// 设置 Placeholder 字号
    func setPlaceholder(font: UIFont) {
        guard let placeholder = self.placeholder else {
            return
        }
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedStringKey.font : font])
    }
    
    /// 设置光标颜色
    func setCursor(color: UIColor) {
        self.tintColor = color
    }
}

public extension UITextField {
    
    convenience init(txtType: TxtKeyboardType, placeholder: String? = "", txtColor: UIColor, txtFont: UIFont, txtAlignment: NSTextAlignment? = .left) {
        self.init()
        self.placeholder = placeholder
        self.textColor = txtColor
        self.font = txtFont
        self.textAlignment = txtAlignment!
        self.clearButtonMode = .whileEditing
        self.autocorrectionType = .no // 不自动更正
        self.autocapitalizationType = .none // 不自动大写
        
        switch txtType {
        case .normal:
            self.keyboardType = .default
        case .number:
            self.keyboardType = .numberPad
        case .price:
            self.keyboardType = .decimalPad
            self.delegate = self
        case .password:
            self.keyboardType = .asciiCapable
            self.isSecureTextEntry = true
        case .url:
            self.keyboardType = .URL
        case .email:
            self.keyboardType = .emailAddress
        }
    }
    
    func addLeftTextPadding(_ blankSize: CGFloat) {
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: blankSize, height: frame.height)
        self.leftView = leftView
        self.leftViewMode = .always
    }
    
    func addLeftIcon(_ image: UIImage?, frame: CGRect) {
        let imgView = UIImageView(image: image)
        imgView.contentMode = .center
        self.leftView = imgView
        self.leftViewMode = .always
    }
    
    
}

extension UITextField: UITextFieldDelegate {
    /// 限制只能输入价格
    fileprivate func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let expression = "^[0-9]+((\\.|,)[0-9]{0,2})?$"
        let regex = try! NSRegularExpression(pattern: expression, options: NSRegularExpression.Options.allowCommentsAndWhitespace)
        let numberOfMatches = regex.numberOfMatches(in: newString, options:NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, (newString as NSString).length))
        if textField.text?.count == 1 { // 否则最后一位删不掉
            return true
        }else {
            return numberOfMatches != 0
        }
    }
}
