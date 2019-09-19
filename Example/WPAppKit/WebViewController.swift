//
//  WebViewController.swift
//  WPAppKit_Example
//
//  Created by 王鹏 on 2019/7/4.
//  Copyright © 2019年 CocoaPods. All rights reserved.
//

import UIKit
import WebKit
import WPAppKit

class WebViewController: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
//        let wkWeb = WKWebView(frame: view.bounds)
//        wkWeb.navigationDelegate = self
//        wkWeb.uiDelegate = self
//        self.view.addSubview(wkWeb)
//        let url = "https://mp.weixin.qq.com/s/3AMTnBGUIPWvyO6QetJrgA"
//        wkWeb.load(URLRequest.init(url: URL.init(string: url)!))
        
//        clearCache()
        
//        if let decodedData = Data.init(base64Encoded: "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVQImWNgYGBgAAAABQABh6FO1AAAAABJRU5ErkJggg==") {
//            print("-----\(decodedData)")
//            let img = UIImage(data: decodedData)
//            let str = String(data: decodedData, encoding: String.Encoding.utf8)
//            print("-----\(str)")
//
//            let imgView = UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
//            imgView.image = img
//            self.view.addSubview(imgView)
//
//        }
//
//        let image = UIImage(named: "hud_success")
//        let imageData = UIImagePNGRepresentation(image!)
//
//        // 将Data转化成 base64的字符串
//        let imageBase64String = imageData?.base64EncodedString()
//        print("-------\(String(describing: imageBase64String))")
    
        
        
//        let decodedString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue)!
//        print(decodedString)
        
        // 配置webView样式
        var config = WkwebViewConfig()
        config.isShowScrollIndicator = false
        config.isProgressHidden = false
        self.webView.webConfig = config
        self.view.addSubview(self.webView)

        let url = "https://www.baidu.com"
        self.webView.webloadType(self, WkwebLoadType.URLString(url: url))
//
        let jsGetImages =
            "function getImages(){" +
                "var objs = document.getElementsByTagName(\"img\");" +
                "var imgScr = '';" +
                "for(var i=0;i<objs.length;i++){" +
                "imgScr = imgScr + objs[i].src + '+';" +
                "};" +
                "return imgScr;" +
        "};"
        webView.run_JavaScript(javaScript: jsGetImages)
    }
    
    lazy var webView: WPWebView = {
        let webView = WPWebView.init(frame: CGRect.init(x: 0, y: DeviceInfo.headerBarHeight, width: ScreenWidth, height: DeviceInfo.withoutHeaderBar))
        webView.delegate = self
        return webView
    }()
    
    func webViewEvaluateJavaScript(_ result: Any?, error: Error?) {
        
        print(result)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let jsGetImages =
                    "function getImages(){" +
                        "var objs = document.getElementsByTagName(\"img\");" +
                        "var imgScr = '';" +
                        "for(var i=0;i<objs.length;i++){" +
                        "imgScr = imgScr + objs[i].src + '+';" +
                        "};" +
                        "return imgScr;" +
                "};"

        webView.evaluateJavaScript(jsGetImages, completionHandler: nil)
        webView.evaluateJavaScript("getImages()") { (data, err) in
            let imageUrl:String = data as! String
            var urlArry = imageUrl.components(separatedBy: "+")
            urlArry.removeLast()
            print(urlArry)
        }
    }
    
}



extension WebViewController: WKWebViewDelegate {
    
    
    
    
    
    
    
    
    
    
    
    
}
