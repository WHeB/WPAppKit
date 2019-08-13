//
//  ScanWrapper.swift
//  swiftScan
//
//  Created by ia on 15/12/10.
//  Copyright © 2015年 xialibing. All rights reserved.
//
//  对 swiftScan 库做的代码规范，修改部分代码，删除一些不需要的代码
//  原地址：https://github.com/CocoaPods/Specs.git

import UIKit
import AVFoundation

public struct  ScanResult {
    
    //码内容
    public var strScanned: String?
    //扫描图像
    public var imgScanned: UIImage?
    //码的类型
    public var strBarCodeType: String?
    //码在图像中的位置
    public var arrayCorner:[AnyObject]?
    
    public init(str:String?, img:UIImage?, barCodeType:String?, corner:[AnyObject]?) {
        self.strScanned = str
        self.imgScanned = img
        self.strBarCodeType = barCodeType
        self.arrayCorner = corner
    }
}

public class ScanWrapper: NSObject,AVCaptureMetadataOutputObjectsDelegate {
    
    let device = AVCaptureDevice.default(for: AVMediaType.video)
    var input:AVCaptureDeviceInput?
    var output:AVCaptureMetadataOutput
    
    let session = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    //存储返回结果
    var arrayResult:[ScanResult] = []
    
    //扫码结果返回block
    var successBlock:([ScanResult]) -> Void
    
    //当前扫码结果是否处理
    var isNeedScanResult: Bool = true
    
    /**
     初始化设备
     - parameter videoPreView: 视频显示UIView
     - parameter objType:      识别码的类型,缺省值 QR二维码
     - parameter cropRect:     识别区域
     - parameter success:      返回识别信息
     - returns:
     */
    init(videoPreView: UIView,
         objType: [AVMetadataObject.ObjectType] = [(AVMetadataObject.ObjectType.qr as NSString) as AVMetadataObject.ObjectType],
         cropRect: CGRect = CGRect.zero,
         success:@escaping (([ScanResult]) -> Void)) {
        do{
            input = try AVCaptureDeviceInput(device: device!)
        }
        catch let error as NSError {
            print("AVCaptureDeviceInput(): \(error)")
        }
        
        successBlock = success
        // Output
        output = AVCaptureMetadataOutput()
        
        super.init()
        
        guard let device = device,
            let input = input else {
            return
        }
        
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        if session.canAddOutput(output) {
            session.addOutput(output)
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            output.metadataObjectTypes = objType
        }
        session.sessionPreset = AVCaptureSession.Preset.high
        
        if !cropRect.equalTo(CGRect.zero) {
            //启动相机后，直接修改该参数无效
            output.rectOfInterest = cropRect
        }
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        var frame: CGRect = videoPreView.frame
        frame.origin = CGPoint.zero
        previewLayer?.frame = frame
        videoPreView.layer .insertSublayer(previewLayer!, at: 0)
        
        if (device.isFocusPointOfInterestSupported && device.isFocusModeSupported(AVCaptureDevice.FocusMode.continuousAutoFocus)) {
            do {
                try input.device.lockForConfiguration()
                input.device.focusMode = AVCaptureDevice.FocusMode.continuousAutoFocus
                input.device.unlockForConfiguration()
            }
            catch let error as NSError {
                print("device.lockForConfiguration(): \(error)")
            }
        }
    }
    
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureOutput(output, didOutputMetadataObjects: metadataObjects, from: connection)
    }
    
    internal func start() {
        if !session.isRunning {
            isNeedScanResult = true
            session.startRunning()
        }
    }
    
    internal func stop() {
        if session.isRunning {
            isNeedScanResult = false
            session.stopRunning()
        }
    }
    
    public func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if !isNeedScanResult {
            //上一帧处理中
            return
        }
        
        isNeedScanResult = false
        arrayResult.removeAll()
        
        //识别扫码类型
        for current: Any in metadataObjects {
            if (current as AnyObject).isKind(of: AVMetadataMachineReadableCodeObject.self) {
                let code = current as! AVMetadataMachineReadableCodeObject
                //码类型
                let codeType = code.type
                //码内容
                let codeContent = code.stringValue
                
                //4个字典，分别 左上角-右上角-右下角-左下角的 坐标百分百，可以使用这个比例抠出码的图像
                // let arrayRatio = code.corners
                arrayResult.append(ScanResult(str: codeContent,
                                                 img: UIImage(),
                                                 barCodeType: codeType.rawValue,
                                                 corner: code.corners as [AnyObject]?))
            }
        }
        
        if arrayResult.count > 0 {
            stop()
            successBlock(arrayResult)
        }else {
            isNeedScanResult = true
        }
    }
    
    public func connectionWithMediaType(mediaType:AVMediaType, connections:[AnyObject]) -> AVCaptureConnection? {
        for connection:AnyObject in connections {
            let connectionTmp:AVCaptureConnection = connection as! AVCaptureConnection
            for port:Any in connectionTmp.inputPorts {
                if (port as AnyObject).isKind(of: AVCaptureInput.Port.self) {
                    let portTmp:AVCaptureInput.Port = port as! AVCaptureInput.Port
                    if portTmp.mediaType == mediaType {
                        return connectionTmp
                    }
                }
            }
        }
        return nil
    }
    
    public func isGetFlash() -> Bool {
        if (device != nil &&
            device!.hasFlash &&
            device!.hasTorch) {
            return true
        }
        return false
    }
    
    /**
     - 打开或关闭闪关灯
     - parameter torch: true：打开闪关灯 false:关闭闪光灯
     */
    public func setTorch(torch: Bool) {
        if isGetFlash() {
            do {
                try input?.device.lockForConfiguration()
                input?.device.torchMode = torch ? AVCaptureDevice.TorchMode.on : AVCaptureDevice.TorchMode.off
                input?.device.unlockForConfiguration()
            }
            catch let error as NSError {
                print("device.lockForConfiguration(): \(error)")
            }
        }
    }
    
    /// 闪光灯打开或关闭
    public func changeTorch() {
        if isGetFlash() {
            do {
                try input?.device.lockForConfiguration()
                var torch = false
                
                if input?.device.torchMode == AVCaptureDevice.TorchMode.on {
                    torch = false
                }
                else if input?.device.torchMode == AVCaptureDevice.TorchMode.off {
                    torch = true
                }
                input?.device.torchMode = torch ? AVCaptureDevice.TorchMode.on : AVCaptureDevice.TorchMode.off
                
                input?.device.unlockForConfiguration()
            }
            catch let error as NSError {
                print("device.lockForConfiguration(): \(error)")
            }
        }
    }
    
    //MARK: ------获取系统默认支持的码的类型
    static func defaultMetaDataObjectTypes() -> [AVMetadataObject.ObjectType] {
        var types =
            [AVMetadataObject.ObjectType.qr,
             AVMetadataObject.ObjectType.upce,
             AVMetadataObject.ObjectType.code39,
             AVMetadataObject.ObjectType.code39Mod43,
             AVMetadataObject.ObjectType.ean13,
             AVMetadataObject.ObjectType.ean8,
             AVMetadataObject.ObjectType.code93,
             AVMetadataObject.ObjectType.code128,
             AVMetadataObject.ObjectType.pdf417,
             AVMetadataObject.ObjectType.aztec
        ]
        
        types.append(AVMetadataObject.ObjectType.interleaved2of5)
        types.append(AVMetadataObject.ObjectType.itf14)
        types.append(AVMetadataObject.ObjectType.dataMatrix)
        return types as [AVMetadataObject.ObjectType]
    }
    
    static func isSysIos8Later()->Bool {
        if #available(iOS 8, *) {
            return true
        }
        return false
    }
    
    /**
     识别二维码码图像
     - parameter image: 二维码图像
     - returns: 返回识别结果
     */
    public static func recognizeQRImage(image:UIImage) -> [ScanResult] {
        var returnResult: [ScanResult] = []
        if ScanWrapper.isSysIos8Later() {
            let detector:CIDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])!
            let img = CIImage(cgImage: (image.cgImage)!)
            let features:[CIFeature]? = detector.features(in: img, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])
            
            if( features != nil && (features?.count)! > 0) {
                let feature = features![0]
                if feature.isKind(of: CIQRCodeFeature.self) {
                    let featureTmp:CIQRCodeFeature = feature as! CIQRCodeFeature
                    let scanResult = featureTmp.messageString
                    let result = ScanResult(str: scanResult, img: image, barCodeType: AVMetadataObject.ObjectType.qr.rawValue,corner: nil)
                    returnResult.append(result)
                }
            }
        }
        return returnResult
    }
    
   
}
