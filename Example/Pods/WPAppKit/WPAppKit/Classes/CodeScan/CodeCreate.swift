//
//  CodeCreate.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/8/13.
//

import UIKit

public class CodeCreate: UIView {

    /// 生成二维码，背景色及二维码颜色设置
    public static func createCode( codeType: String,
                                   codeString: String,
                                   size: CGSize,
                                   qrColor: UIColor,
                                   bkColor: UIColor) -> UIImage? {
        
        let stringData = codeString.data(using: String.Encoding.utf8)
        // 系统自带能生成的码
        // CIAztecCodeGenerator
        // CICode128BarcodeGenerator
        // CIPDF417BarcodeGenerator
        // CIQRCodeGenerator
        let qrFilter = CIFilter(name: codeType)
        qrFilter?.setValue(stringData, forKey: "inputMessage")
        qrFilter?.setValue("H", forKey: "inputCorrectionLevel")
        //上色
        let colorFilter = CIFilter(name: "CIFalseColor",
                                   parameters: ["inputImage": qrFilter!.outputImage!,
                                                         "inputColor0": CIColor(cgColor: qrColor.cgColor),
                                                         "inputColor1": CIColor(cgColor:  bkColor.cgColor)])
        let qrImage = colorFilter!.outputImage!
        //绘制
        let cgImage = CIContext().createCGImage(qrImage, from: qrImage.extent)!
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()!
        context.interpolationQuality = CGInterpolationQuality.none
        context.scaleBy(x: 1.0, y: -1.0)
        context.draw(cgImage, in: context.boundingBoxOfClipPath)
        let codeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return codeImage
    }
    
    public static func createCode128(codeString: String,
                                     size:CGSize,
                                     qrColor:UIColor,
                                     bkColor:UIColor) -> UIImage? {
        let stringData = codeString.data(using: String.Encoding.utf8)
        
        // 系统自带能生成的码
        // CIAztecCodeGenerator
        // CICode128BarcodeGenerator
        // CIPDF417BarcodeGenerator
        // CIQRCodeGenerator
        let qrFilter = CIFilter(name: "CICode128BarcodeGenerator")
        qrFilter?.setDefaults()
        qrFilter?.setValue(stringData, forKey: "inputMessage")
        
        let outputImage:CIImage? = qrFilter?.outputImage
        let context = CIContext()
        let cgImage = context.createCGImage(outputImage!, from: outputImage!.extent)
        
        let image = UIImage(cgImage: cgImage!, scale: 1.0, orientation: UIImage.Orientation.up)
        
        // Resize without interpolating
        let scaleRate:CGFloat = 20.0
        let resized = resizeImage(image: image, quality: CGInterpolationQuality.none, rate: scaleRate)
        return resized
    }
    
    /// MARK:根据扫描结果，获取图像中得二维码区域图像（如果相机拍摄角度故意很倾斜，获取的图像效果很差）
    static func getConcreteCodeImage(srcCodeImage: UIImage, codeResult: ScanResult) -> UIImage? {
        let rect:CGRect = getConcreteCodeRectFromImage(srcCodeImage: srcCodeImage, codeResult: codeResult)
        
        if rect.isEmpty {
            return nil
        }
        guard let img = imageByCroppingWithStyle(srcImg: srcCodeImage, rect: rect) else {
            return nil
        }
        let imgRotation = imageRotation(image: img, orientation: UIImage.Orientation.right)
        return imgRotation
    }
    /// 根据二维码的区域截取二维码区域图像
    public static func getConcreteCodeImage(srcCodeImage: UIImage, rect: CGRect) -> UIImage? {
        if rect.isEmpty {
            return nil
        }
        guard let img = imageByCroppingWithStyle(srcImg: srcCodeImage, rect: rect) else {
            return nil
        }
        let imgRotation = imageRotation(image: img, orientation: UIImage.Orientation.right)
        return imgRotation
    }
    
    /// 获取二维码的图像区域
    public static func getConcreteCodeRectFromImage(srcCodeImage: UIImage, codeResult: ScanResult)->CGRect {
        if (codeResult.arrayCorner == nil ||
            (codeResult.arrayCorner?.count)! < 4) {
            return CGRect.zero
        }
        
        let corner:[[String:Float]] = codeResult.arrayCorner as! [[String:Float]]
        
        let dicTopLeft     = corner[0]
        let dicTopRight    = corner[1]
        let dicBottomRight = corner[2]
        let dicBottomLeft  = corner[3]
        
        let xLeftTopRatio:Float = dicTopLeft["X"]!
        let yLeftTopRatio:Float  = dicTopLeft["Y"]!
        
        let xRightTopRatio:Float = dicTopRight["X"]!
        let yRightTopRatio:Float = dicTopRight["Y"]!
        
        let xBottomRightRatio:Float = dicBottomRight["X"]!
        let yBottomRightRatio:Float = dicBottomRight["Y"]!
        
        let xLeftBottomRatio:Float = dicBottomLeft["X"]!
        let yLeftBottomRatio:Float = dicBottomLeft["Y"]!
        
        //由于截图只能矩形，所以截图不规则四边形的最大外围
        let xMinLeft = CGFloat( min(xLeftTopRatio, xLeftBottomRatio) )
        let xMaxRight = CGFloat( max(xRightTopRatio, xBottomRightRatio) )
        
        let yMinTop = CGFloat( min(yLeftTopRatio, yRightTopRatio) )
        let yMaxBottom = CGFloat ( max(yLeftBottomRatio, yBottomRightRatio) )
        
        let imgW = srcCodeImage.size.width
        let imgH = srcCodeImage.size.height
        
        //宽高反过来计算
        let rect = CGRect(x: xMinLeft * imgH, y: yMinTop*imgW, width: (xMaxRight-xMinLeft)*imgH, height: (yMaxBottom-yMinTop)*imgW)
        return rect
    }
    
    /// 图像中间加logo图片
    ///
    /// - Parameters:
    ///   - srcImg: 原图像
    ///   - logoImg: logo图像
    ///   - logoSize: logo图像尺寸
    /// - Returns: 加Logo的图像
    public static func addImageLogo(srcImg: UIImage, logoImg: UIImage, logoSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(srcImg.size)
        srcImg.draw(in: CGRect(x: 0, y: 0, width: srcImg.size.width, height: srcImg.size.height))
        let rect = CGRect(x: srcImg.size.width/2 - logoSize.width/2, y: srcImg.size.height/2-logoSize.height/2, width:logoSize.width, height: logoSize.height)
        logoImg.draw(in: rect)
        let resultingImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultingImage!
    }
    
    /// 图像缩放
    private static func resizeImage(image:UIImage, quality:CGInterpolationQuality, rate:CGFloat) -> UIImage? {
        var resized:UIImage?
        let width    = image.size.width * rate
        let height   = image.size.height * rate
        
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        let context = UIGraphicsGetCurrentContext()
        context!.interpolationQuality = quality
        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        
        resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resized
    }
    
    /// 图像裁剪
    private static func imageByCroppingWithStyle(srcImg: UIImage,rect: CGRect) -> UIImage? {
        let imageRef = srcImg.cgImage
        let imagePartRef = imageRef!.cropping(to: rect)
        let cropImage = UIImage(cgImage: imagePartRef!)
        
        return cropImage
    }
    
    /// 图像旋转
    private static func imageRotation(image:UIImage, orientation: UIImage.Orientation) -> UIImage {
        var rotate:Double = 0.0
        var rect:CGRect
        var translateX:CGFloat = 0.0
        var translateY:CGFloat = 0.0
        var scaleX:CGFloat = 1.0
        var scaleY:CGFloat = 1.0
        
        switch (orientation) {
        case UIImage.Orientation.left:
            rotate = .pi/2
            rect = CGRect(x: 0, y: 0, width: image.size.height, height: image.size.width)
            translateX = 0
            translateY = -rect.size.width
            scaleY = rect.size.width/rect.size.height
            scaleX = rect.size.height/rect.size.width
            break
        case UIImage.Orientation.right:
            rotate = 3 * .pi/2
            rect = CGRect(x: 0, y: 0, width: image.size.height, height: image.size.width)
            translateX = -rect.size.height
            translateY = 0
            scaleY = rect.size.width/rect.size.height
            scaleX = rect.size.height/rect.size.width
            break
        case UIImage.Orientation.down:
            rotate = .pi
            rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
            translateX = -rect.size.width
            translateY = -rect.size.height
            break
        default:
            rotate = 0.0
            rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
            translateX = 0
            translateY = 0
            break
        }
        
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        //做CTM变换
        context.translateBy(x: 0.0, y: rect.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.rotate(by: CGFloat(rotate))
        context.translateBy(x: translateX, y: translateY)
        
        context.scaleBy(x: scaleX, y: scaleY)
        //绘制图片
        context.draw(image.cgImage!, in: CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height))
        let newPic = UIGraphicsGetImageFromCurrentImageContext()
        
        return newPic!
    }
}
