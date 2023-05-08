//
//  LocalStoreTool.swift
//  WPAppKit
//  本地数据持久化
//  Created by 王鹏 on 2019/4/10.
//  Copyright © 2019年 王海鹏. All rights reserved.
//

import UIKit

public class LocalStoreTool: NSObject {
    
    /// 实例化本利存储工具
    public static let share = LocalStoreTool()
    private override init() { }
    
    /// document文件路径
    public func documentFileName(fileName: String) -> String {
        let pathArray = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentPath: String = pathArray.last!
        // 防止文件头有“/”出错
        var pathString: String = ""
        if fileName.hasPrefix("/") {
            pathString = documentPath + fileName
        }else {
            pathString = documentPath + "/" + fileName
        }
        return pathString
    }
    
    /// 判断文件是否存在
    public func isExistFileOfDocument(fileName: String) -> Bool {
        let manger = FileManager.default
        var isDir: ObjCBool = false
        // 注意：这里判断document文件下文件是否存在
        let isExist: Bool = manger.fileExists(atPath: self.documentFileName(fileName: fileName), isDirectory: &isDir)
        return isExist
    }
    
    /// 删除文件
    public func deleteFileOfDocument(fileName: String) {
        // 文件不存在则返回
        guard self.isExistFileOfDocument(fileName: fileName) else {
            print("File does not exist")
            return
        }
        // 存在则删除
        let manger = FileManager.default
        do {
            try manger.removeItem(atPath: self.documentFileName(fileName: fileName))
        } catch {
            print("Delete failed")
        }
    }
    
    /// 归档
    public func archiverInfo(objectName: Any, fileName: String) {
        let data: NSMutableData = NSMutableData()
        let archiver = NSKeyedArchiver.init(forWritingWith: data)
        archiver.encode(objectName, forKey: fileName)
        archiver.finishEncoding()
        //数据写入
        data.write(toFile: self.documentFileName(fileName: fileName), atomically: true)
    }
    
    /// 解档
    public func unarchiverInfo(pathKey: String) -> Any {
        let filePath = self.documentFileName(fileName: pathKey)
        let data: NSMutableData = try! NSMutableData.init(contentsOfFile: filePath)
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
        let info = unarchiver.decodeObject(forKey: pathKey)
        unarchiver.finishDecoding()
        return info as Any
    }
    
    /// 写入数组
    public func writeArrayToPlist(plistPath: String, fileArray: [Any]) {
        let filePath = self.documentFileName(fileName: plistPath)
        NSArray(array: fileArray).write(toFile: filePath, atomically: true)
    }
    
    /// 读取数组
    public func readArrayOfPlist(plistPath: String) -> [Any] {
        // 文件不存在则返回
        guard self.isExistFileOfDocument(fileName: plistPath) else {
            print("File does not exist")
            return []
        }
        let filePath = self.documentFileName(fileName: plistPath)
        let array = NSArray.init(contentsOfFile: filePath)
        return array as! [Any]
    }
    
    /// 写入字典
    public func writeDictToPlist(plistPath: String, dict: [String : Any]) {
        let filePath = self.documentFileName(fileName: plistPath)
        (dict as NSDictionary).write(toFile: filePath, atomically: true)
    }
    
    /// 读取字典
    public func readDictOfPlist(plistPath: String) -> [String : Any] {
        guard self.isExistFileOfDocument(fileName: plistPath) else {
            print("File does not exist")
            return Dictionary.init()
        }
        let filePath = self.documentFileName(fileName: plistPath)
        let dict = NSDictionary.init(contentsOfFile: filePath)
        return dict as! [String : Any]
    }
    
    /// 写入字符串
    public func writeString(toFilePath: String, string: String) {
        let filePath = self.documentFileName(fileName: toFilePath)
        try? (string as NSString).write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8.rawValue)
    }
    
    /// 读取字符串
    public func readString(toFilePath: String) -> String {
        guard self.isExistFileOfDocument(fileName: toFilePath) else {
            print("File does not exist")
            return ""
        }
        let filePath = self.documentFileName(fileName: toFilePath)
        guard let data = FileManager.default.contents(atPath: filePath) else {
            return ""
        }
        guard let string = String(data: data, encoding: String.Encoding.utf8) else {
            return ""
        }
        return string
    }
    
}
