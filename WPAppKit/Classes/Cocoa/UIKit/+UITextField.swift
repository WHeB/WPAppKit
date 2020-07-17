//
//  +UITextField.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/4/15.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

public enum TxtKeyboardType {
    case normal                 // 默认 支持所有字符
    case number                 // 纯数字
    case pointNumber            // 数字+点
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
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color])
    }
    
    /// 设置 Placeholder 字号
    func setPlaceholder(font: UIFont) {
        guard let placeholder = self.placeholder else {
            return
        }
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.font : font])
    }
    
    /// 设置光标颜色
    func setCursor(color: UIColor) {
        self.tintColor = color
    }
}

public extension UITextField {
    
    convenience init(txtType: TxtKeyboardType,
                     placeholder: String? = "",
                     txtColor: UIColor,
                     txtFont: UIFont,
                     txtAlignment: NSTextAlignment? = .left) {
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
        case .pointNumber:
            self.keyboardType = .decimalPad
        case .password:
            self.keyboardType = .asciiCapable
            self.isSecureTextEntry = true
        case .url:
            self.keyboardType = .URL
        case .email:
            self.keyboardType = .emailAddress
        }
    }
    
    /// 添加左侧间距
    func addLeftTextPadding(_ blankSize: CGFloat) {
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: blankSize, height: frame.height)
        self.leftView = leftView
        self.leftViewMode = .always
    }
    
    /// 在左侧添加图片
    func addLeftIcon(_ image: UIImage?, frame: CGRect) {
        let imgView = UIImageView(image: image)
        imgView.frame = frame
        imgView.contentMode = .center
        self.leftView = imgView
        self.leftViewMode = .always
    }
    
    /// 含一个小数点的输入框
    convenience init(placeholder: String? = "",
                     txtColor: UIColor,
                     txtFont: UIFont,
                     txtAlignment: NSTextAlignment? = .left,
                     integerLength: Int? = 8,
                     decimalLength: Int? = 2) {
        self.init()
        self.placeholder = placeholder
        self.textColor = txtColor
        self.font = txtFont
        self.textAlignment = txtAlignment!
        self.clearButtonMode = .whileEditing
        self.autocorrectionType = .no // 不自动更正
        self.autocapitalizationType = .none // 不自动大写
        self.keyboardType = .decimalPad
        self.integerLength = integerLength
        self.decimalLength = decimalLength
        self.delegate = self
    }
}

var integerLengthKey: Void?
var decimalLengthKey: Void?
extension UITextField: UITextFieldDelegate {
    
    /// 整数部分长度
    var integerLength: Int? {
        set(newValue) {
            objc_setAssociatedObject(self, &integerLengthKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &integerLengthKey) as? Int
        }
    }
    
    /// 小数部分长度
    var decimalLength: Int? {
        set(newValue) {
            objc_setAssociatedObject(self, &decimalLengthKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &decimalLengthKey) as? Int
        }
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let integerLength = self.integerLength ?? 8  // 小数点前可以输入
        if textField.text?.contains(".") == false &&
            string != "" && string != "." {
            if (textField.text?.count)! > integerLength {
                return false
            }
        }
        let scanner = Scanner(string: string)
        let numbers : NSCharacterSet
        let pointRange = (textField.text! as NSString).range(of: ".")
        
        if (pointRange.length > 0) &&
            pointRange.length < range.location
            || pointRange.location > range.location + range.length {
            numbers = NSCharacterSet(charactersIn: "0123456789.")
        }else{
            numbers = NSCharacterSet(charactersIn: "0123456789.")
        }
        if textField.text == "" &&
            string == "." {
            return false
        }
        
        let remain = self.decimalLength ?? 2 // 小数点后2位
        let tempStr = textField.text!.appending(string)
        let strlen = tempStr.count
        if pointRange.length > 0 && pointRange.location > 0 {
            //判断输入框内是否含有“.”
            if string == "." {
                return false
            }
            if strlen > 0 &&
                (strlen - pointRange.location) > remain + 1 {
                //当输入框内已经含有“.”，当字符串长度减去小数点前面的字符串长度大于需要要保留的小数点位数，则视当次输入无效。
                return false
            }
        }
        let zeroRange = (textField.text! as NSString).range(of: "0")
        if zeroRange.length == 1 &&
            zeroRange.location == 0 {
            //判断输入框第一个字符是否为“0”
            if !(string == "0") &&
                !(string == ".") &&
                textField.text?.count == 1 {
                //当输入框只有一个字符并且字符为“0”时，再输入不为“0”或者“.”的字符时，则将此输入替换输入框的这唯一字符。
                textField.text = string
                return false
            }else {
                if pointRange.length == 0 &&
                    pointRange.location > 0 {
                    //当输入框第一个字符为“0”时，并且没有“.”字符时，如果当此输入的字符为“0”，则视当此输入无效。
                    if string == "0" {
                        return false
                    }
                }
            }
        }
        if !scanner.scanCharacters(from: numbers as CharacterSet, into: nil) && string.count != 0 {
            return false
        }
        return true
    }
    
}
