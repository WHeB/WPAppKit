//
//  FileUtils.swift
//  Kingfisher
//
//  Created by 王鹏 on 2019/6/30.
//

import UIKit

class FileUtils: NSObject {
    
    /// 获取文件类型
    public class func getFileType(data: Data) -> String {
        var bytes : UInt8 = 0
        data.copyBytes(to: &bytes, count: 1)
        switch bytes {
        case 0xFF:
            return "image/jpeg"
        case 0x89:
            return "image/png"
        case 0x47:
            return "image/gif"
        case 0x49,0x4D:
            return "image/tiff"
        case 0x25:
            return "application/pdf"
        case 0xD0:
            return "application/vnd"
        case 0x46:
            return "text/plain"
        default:
            return "application/octet-stream"
        }
    }
    
    /// 拷贝文件到沙盒tmp目录，返回沙箱文件url
    public class func copyFileToTmp(_ file: Data, name: String) -> URL? {
        let fileMgr = FileManager.default
        let tmpDir = NSTemporaryDirectory()
        let path = tmpDir + name
        if fileMgr.createFile(atPath: path, contents: file, attributes: nil){
            return URL(fileURLWithPath: path)
        }else{
            return nil
        }
    }
    
    /// 拷贝Assets中.png图片资源到缓存目录，返回文件url
    public class func createLocalUrl(forImageNamed name: String) -> URL? {
        
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let url = cacheDirectory.appendingPathComponent("\(name).png")
        let path = url.path
        guard fileManager.fileExists(atPath: path) else {
            guard
                let image = UIImage(named: name),
                let data = UIImagePNGRepresentation(image)
                else { return nil }
            
            fileManager.createFile(atPath: path, contents: data, attributes: nil)
            return url
        }
        return url
    }
    
}
