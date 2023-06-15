//
//  SystemPermission.swift
//  HBDNavigationBar
//
//  Created by 王鹏 on 2019/11/5.
//

import UIKit
import AVFoundation
import Photos
import CoreLocation

public class SystemPermission: NSObject {
    
    /// 访问相册权限
    /// Privacy - Photo Library Usage Description (读取)
    /// Privacy - Photo Library Additions Usage Description (写入)
    public class func isOpenPhotoLibrary(comletion:@escaping (Bool) -> Void) {
        let authStatus = PHPhotoLibrary.authorizationStatus()
        switch authStatus {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization {
                comletion($0 == .authorized ? true : false)
            }
            break
        case .restricted, .denied:
            comletion(false)
            break
        case .authorized:
            comletion(true)
            break
        @unknown default:
            break
        }
    }
    
    /// 访问相机权限
    /// Privacy - Camera Usage Description
    public class func isOpenCamera(comletion:@escaping (Bool) -> Void) {
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authStatus {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) {
                comletion($0)
            }
            break
        case .restricted, .denied:
            comletion(false)
            break
        case .authorized:
            comletion(true)
            break
        @unknown default:
            break
        }
    }
    
    /// 麦克风权限
    /// Privacy - Microphone Usage Description
    public class func isOpenMicrophone(comletion:@escaping (Bool) -> Void) {
        let authStatus = AVCaptureDevice.authorizationStatus(for: .audio)
        switch authStatus {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .audio) {
                comletion($0)
            }
            break
        case .restricted, .denied:
            comletion(false)
            break
        case .authorized:
            comletion(true)
            break
        @unknown default:
            break
        }
    }
    
    /// 推送权限
    /*
     case notDetermined  // 不确定，还没有让用户选择
     case denied         // 不允许
     case authorized     // 允许
     */
    public class func isOpenNotification(callBlock:@escaping (_ isOpen: UNAuthorizationStatus)->()) {
        UNUserNotificationCenter.current().getNotificationSettings { (set) in
            let status = set.authorizationStatus
            callBlock(status)
        }
    }
    
    /// 定位权限
    /// Privacy - Location When In Use Usage Description (使用期间)
    /// Privacy - Location Always and When In Use Usage Description (总是)
    public class func isOpenLocation() -> Bool {
        let location = CLLocationManager.locationServicesEnabled()
        if !location {
            return false
        }
        let authStatus = CLLocationManager.authorizationStatus()
        if authStatus == .denied ||
            authStatus == .restricted {
            return false
        }
        return true
    }
    
}
