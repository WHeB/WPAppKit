//
//  PhotoManger.swift
//  HBDNavigationBar
//
//  Created by 王鹏 on 2019/11/8.
//
//  拍照，相册，图片压缩
import UIKit

public protocol PhotoMangerDelegate: NSObjectProtocol {
    func didFinish(image: UIImage, imgData: Data)
}

// 完成选择
public typealias DidFinish = (_ image: UIImage, _ imgData: Data) -> ()
public typealias SaveFinish = (_ result: Bool) -> ()

public class PhotoManger: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public static let share = PhotoManger()
    private override init() { }
    /// 选中结果
    public weak var delegate: PhotoMangerDelegate?
    public var finishBlock: DidFinish?
    public var saveBlock: SaveFinish?
    /// 是否将照片保存到相册
    public var savePhoto: Bool = false
    /// 压缩大小系数（100-1024KB）
    public var reduceLevel: Int = 400
    /// 绝对值范围 (压缩系数的偏差范围)
    public var absRange: Int = 100
    /// 是否编辑图片
    public var allowEdit: Bool = false
    
    /// 拍照
    public func takePhoto() {
        guard let vc = CurrentManager.getCurrentViewController() else {
            return
        }
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerController.SourceType.camera
        picker.allowsEditing = self.allowEdit
        picker.delegate = self
        vc.present(picker, animated: true, completion: nil)
    }
    
    /// 从相册选择
    public func libraryPicker() {
        guard let vc = CurrentManager.getCurrentViewController() else {
            return
        }
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.allowsEditing = self.allowEdit
        picker.delegate = self
        vc.present(picker, animated: true, completion: nil)
    }
    
    // 拍照或选择照片 UIImagePickerControllerDelegate
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let vc = CurrentManager.getCurrentViewController() else {
            return
        }
        guard let image: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        let finalData = self.resetSizeOfImageData(image: image)
        // 拍照后保存
        if picker.sourceType == .camera && self.savePhoto {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
        }
        
        self.finishBlock?(image, finalData)
        self.delegate?.didFinish(image: image, imgData: finalData)
        vc.dismiss(animated: true, completion: nil)
    }
    
    // 取消
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        guard let vc = CurrentManager.getCurrentViewController() else {
            return
        }
        vc.dismiss(animated: true, completion: nil)
    }
    
    // 保存到相册
    @objc func image(image:UIImage,didFinishSavingWithError error:NSError?,contextInfo:AnyObject) {
        let result = error == nil ? true : false
        saveBlock?(result)
    }
}


extension PhotoManger {
    
    // 默认设置
    private func normalSetting() {
        if self.reduceLevel < 100 {
            self.reduceLevel = 100
        }else if self.reduceLevel > 1024 {
            self.reduceLevel = 1024
        }
        if self.absRange > self.reduceLevel || self.absRange <= 0 {
            self.absRange = 30
        }
    }
    
    // 压缩
    private func resetSizeOfImageData(image: UIImage) -> Data {
        // 获取默认设置
        self.normalSetting()
        
        // 1
        var finalData = UIImageJPEGRepresentation(image, 1.0)
        let firstFinish = self.isFinishReset(data: finalData!)
        if firstFinish { // 合适
            return finalData!
        }
        
        // 2
        let defaultSize = CGSize.init(width: 1024, height: 1024)
        let newImage = self.newSizeImage(size: defaultSize, image: image)
        finalData = UIImageJPEGRepresentation(newImage, 1.0)
        let secondFinish = self.isFinishReset(data: finalData!)
        if secondFinish {
            return finalData!
        }
        
        // 3
        var qualityArr: [Float] = Array()
        let avg: Float = 1.0 / 200
        for i in (1...200).reversed() { // 倒序 1.0 ... 1.0/200
            let vaule: Float = Float(i) * avg
            qualityArr.append(vaule)
        }
        finalData = self.binarySearch(array: qualityArr, image: image)
        return finalData!
    }
    
    // 判断是否压缩到合适大小
    private func isFinishReset(data: Data) -> Bool {
        let originSize = (data.count) / 1024
        // 和目标值相差30Kb则满足要求
        if abs(originSize - self.reduceLevel) <= self.absRange {
            return true
        }
        return false
    }
    
    // 调整图片分辨率/尺寸（等比例缩放)
    private func newSizeImage(size: CGSize, image: UIImage) -> UIImage {
        var newSize = image.size
        let tempWidth = newSize.width / size.width
        let tempHeight = newSize.height / size.height
        
        if tempWidth > 1.0 && tempWidth > tempHeight { // 宽图
            newSize = CGSize(width: image.size.width, height: image.size.height/tempWidth)
        }else if tempHeight > 1.0 && tempWidth < tempHeight { // 长图
            newSize = CGSize(width: image.size.width, height: image.size.height/tempHeight)
        }
        
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    // 二分查找
    private func binarySearch(array: [Float], image: UIImage) -> Data {
        var start = 0
        var end = array.count - 1
        var mid = 0
        var finalData: Data?
        while start <= end {
            mid = start + (end - start) / 2
            finalData = UIImageJPEGRepresentation(image, CGFloat(array[mid]))
            let originSize = (finalData?.count)! / 1024
            // 和目标值相差30Kb则满足要求
            if abs(originSize - self.reduceLevel) <= self.absRange {
                break
            }else if originSize > self.reduceLevel {
                start = mid + 1
            }else if originSize < self.reduceLevel {
                end = mid - 1
            }
        }
        return finalData!
    }
}
