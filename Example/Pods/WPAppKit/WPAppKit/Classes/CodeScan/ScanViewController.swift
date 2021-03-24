//
//  ScanViewController.swift
//  swiftScan
//
//  Created by ia on 15/12/8.
//  Copyright © 2015年 xialibing. All rights reserved.
//
//  对 swiftScan 库做的代码规范，修改部分代码，删除一些不需要的代码
//  原地址：https://github.com/CocoaPods/Specs.git

import UIKit
import Foundation
import AVFoundation

public protocol ScanViewControllerDelegate: class {
     func scanFinished(scanResult: ScanResult, error: String?)
}

public protocol QRRectDelegate {
    func drawwed()
}

open class ScanViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
 //返回扫码结果，也可以通过继承本控制器，改写该handleCodeResult方法即可
   open weak var scanResultDelegate: ScanViewControllerDelegate?
    
    open var delegate: QRRectDelegate?
    open var scanObj: ScanWrapper?
    open var scanStyle = ScanViewStyle()
    open var qRScanView: ScanView?

    //启动区域识别功能
    open var isOpenInterestRect = false
    //识别码的类型
    public var arrayCodeType: [AVMetadataObject.ObjectType]!

    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        
        createScanObj()
    }
    
    //设置框内识别
    open func setOpenInterestRect(isOpen:Bool){
        isOpenInterestRect = isOpen
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        drawScanView()
        startScan()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        qRScanView?.stopScanAnimation()
        scanObj?.stop()
    }
    
    private func createScanObj() {
        if (scanObj == nil) {
            var cropRect = CGRect.zero
            if isOpenInterestRect {
                cropRect = ScanView.getScanRectWithPreView(preView: self.view, style:scanStyle)
            }
            //指定识别几种码
            if arrayCodeType == nil {
                arrayCodeType = [AVMetadataObject.ObjectType.qr,
                                 AVMetadataObject.ObjectType.ean13 ,
                                 AVMetadataObject.ObjectType.code128]
            }
            
            scanObj = ScanWrapper(videoPreView: self.view,
                                     objType: arrayCodeType!,
                                     cropRect: cropRect,
                                     success: { [weak self] (arrayResult) -> Void in
                if let strongSelf = self {
                    //停止扫描动画
                    strongSelf.qRScanView?.stopScanAnimation()
                    strongSelf.handleCodeResult(arrayResult: arrayResult)
                }
            })
        }
    }
    
    @objc private func startScan() {
        //开始扫描动画
        qRScanView?.startScanAnimation()
        //相机运行
        scanObj?.start()
    }
    
    private func drawScanView() {
        if qRScanView == nil {
            qRScanView = ScanView(frame: self.view.frame,vstyle:scanStyle)
            self.view.addSubview(qRScanView!)
            delegate?.drawwed()
        }
    }
   
    /**
     处理扫码结果，如果是继承本控制器的，可以重写该方法,作出相应地处理，或者设置delegate作出相应处理
     */
    open func handleCodeResult(arrayResult: [ScanResult]) {
        if let delegate = scanResultDelegate  {
            self.navigationController? .popViewController(animated: true)
            let result:ScanResult = arrayResult[0]
            
            delegate.scanFinished(scanResult: result, error: nil)
        }else{
            for result:ScanResult in arrayResult {
                print("%@",result.strScanned ?? "")
            }
            let result: ScanResult = arrayResult[0]
            print("%@",result)
        }
    }
    
    open func openPhotoAlbum() {
        Permissions.authorizePhotoWith { [weak self] (granted) in
            let picker = UIImagePickerController()
            picker.sourceType = UIImagePickerController.SourceType.photoLibrary
            picker.delegate = self;
            picker.allowsEditing = true
           self?.present(picker, animated: true, completion: nil)
        }
    }
    
    //MARK: -----相册选择图片识别二维码 （条形码没有找到系统方法）
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        var image: UIImage? = info[UIImagePickerController.InfoKey.editedImage.rawValue] as? UIImage
        if (image == nil) {
            image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage
        }
        if(image != nil) {
            let arrayResult = ScanWrapper.recognizeQRImage(image: image!)
            if arrayResult.count > 0 {
                handleCodeResult(arrayResult: arrayResult)
                return
            }
        }
    }
    
}
