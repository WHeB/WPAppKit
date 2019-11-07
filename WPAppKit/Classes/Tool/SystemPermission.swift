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

@available(iOS 9.0, *)
public class SystemPermission: NSObject {
    
    /// 访问相册权限
    /// Privacy - Photo Library Usage Description (读取)
    /// Privacy - Photo Library Additions Usage Description (写入)
    public static func isOpenPhotoLibrary(comletion:@escaping (Bool) -> Void) {
        let authStatus = PHPhotoLibrary.authorizationStatus()
        switch authStatus {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization {
                comletion($0 == .authorized ? true : false)
            }
        case .restricted, .denied:
            comletion(false)
        case .authorized:
            comletion(true)
        }
    }
    
    /// 访问相机权限
    /// Privacy - Camera Usage Description
    public static func isOpenCamera(comletion:@escaping (Bool) -> Void) {
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authStatus {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) {
                comletion($0)
            }
        case .restricted, .denied:
            comletion(false)
        case .authorized:
            comletion(true)
        }
    }
    
    /// 麦克风权限
    /// Privacy - Microphone Usage Description
    public static func isOpenMicrophone(comletion:@escaping (Bool) -> Void) {
        let authStatus = AVCaptureDevice.authorizationStatus(for: .audio)
        switch authStatus {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .audio) {
                comletion($0)
            }
        case .restricted, .denied:
            comletion(false)
        case .authorized:
            comletion(true)
        }
    }
    
    /// 推送权限
    public static func isOpenPush() -> Bool {
        let setting = UIApplication.shared.currentUserNotificationSettings
        if setting?.types == .alert ||
            setting?.types == .sound ||
            setting?.types == .badge {
            return true
        }
        return false
    }
    
    /// 定位权限
    /// Privacy - Location When In Use Usage Description (使用期间)
    /// Privacy - Location Always and When In Use Usage Description (总是)
    public static func isOpenLocation() -> Bool {
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
