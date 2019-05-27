//
//  UITextField+Convenience.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/16.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

public enum TxtKeyboardType {
    case normal                 // 默认 支持所有字符
    case number                 // 纯数字
    case price                  // 价格 小数点后两位
    case password               // 密码
    case url                    // URL键盘，有.com按钮
}

public extension UITextField {
    
    public convenience init(txtType: TxtKeyboardType, placeholder: String? = "", txtColor: UIColor, txtFont: UIFont, txtAlignment: NSTextAlignment? = .left) {
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
        }
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
