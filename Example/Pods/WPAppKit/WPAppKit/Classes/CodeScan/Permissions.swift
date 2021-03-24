//
//  Permissions.swift
//  swiftScan
//
//  Created by xialibing on 15/12/15.
//  Copyright © 2015年 xialibing. All rights reserved.
//
//  对 swiftScan 库做的代码规范，修改部分代码，删除一些不需要的代码
//  原地址：https://github.com/CocoaPods/Specs.git

import UIKit
import AVFoundation
import Photos
import AssetsLibrary

class Permissions: NSObject {

    //MARK: ----获取相册权限
    static func authorizePhotoWith(comletion:@escaping (Bool) -> Void) {
        let granted = PHPhotoLibrary.authorizationStatus()
        switch granted {
        case PHAuthorizationStatus.authorized:
            comletion(true)
        case PHAuthorizationStatus.denied,PHAuthorizationStatus.restricted:
            comletion(false)
        case PHAuthorizationStatus.notDetermined:
            PHPhotoLibrary.requestAuthorization({ (status) in
                DispatchQueue.main.async {
                    comletion(status == PHAuthorizationStatus.authorized ? true:false)
                }
            })
        @unknown default:
            break
        }
    }
    
    //MARK: ---相机权限
    static func authorizeCameraWith(comletion:@escaping (Bool)->Void ) {
        let granted = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch granted {
        case .authorized:
            comletion(true)
            break
        case .denied:
            comletion(false)
            break
        case .restricted:
            comletion(false)
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted:Bool) in
                DispatchQueue.main.async {
                    comletion(granted)
                }
            })
        }
    }
    
    //MARK:跳转到APP系统设置权限界面
    static func jumpToSystemPrivacySetting() {
        let appSetting = URL(string: UIApplication.openSettingsURLString)
        if appSetting != nil {
            if #available(iOS 10, *) {
                UIApplication.shared.open(appSetting!, options: [:], completionHandler: nil)
            }
            else{
                UIApplication.shared.openURL(appSetting!)
            }
        }
    }
    
}
