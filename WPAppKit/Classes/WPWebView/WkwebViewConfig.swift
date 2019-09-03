//  WkwebViewConfig.swift
//  WPWebView
//
//  Created by admin on 2018/10/25.
//  Copyright © 2018年 wangpeng. All rights reserved.
//

import Foundation
import WebKit

public struct WkwebViewConfig {
    
    /// WKScriptMessageHandler
    /// 添加一个名称，就可以在JS通过这个名称发送消息：valueName自定义名字
    /// window.webkit.messageHandlers.valueName.postMessage({body: 'xxx'})
    public var scriptMessageHandlerArray: [String] = [String]()
    
    /// 默认最小字体字体
    public var minFontSize: CGFloat = 0
    
    /// 显示滚动条
    public var isShowScrollIndicator: Bool = true
    
    /// 开启手势交互
    public var isAllowsBackForwardGestures: Bool = true
    
    /// 是否允许加载javaScript
    public var isjavaScriptEnabled: Bool = true
    
    /// 是否允许JS自动打开窗口的，必须通过用户交互才能打开
    public var isAutomaticallyJavaScript: Bool = true
    
    /// 是否影藏进度条
    public var isProgressHidden: Bool = false
    
    /// 进度条高度
    public var progressHeight: CGFloat = 3
    
    /// 默认颜色
    public var progressTrackTintColor: UIColor = UIColor.clear
    
    /// 加载颜色
    public var progressTintColor: UIColor = UIColor.green
    
    /// 配置支付宝支付成功返回指定APPScheme
    public var aliPayScheme: String = "zhifubao"
    
    public init() {}
}

//网页加载类型
public enum WkwebLoadType {
    
    /// 加载普通URL
    case URLString(url:String)
    
    /// 加载本地HTML(传名字就可以了)
    case HTMLName(name:String)
    
    /// 加载POST请求(url:请求URL，parameters：请求参数)
    case POST(url:String,parameters: [String:Any])
}

public protocol WKWebViewDelegate: class {
    
    /// 服务器开始请求的时候调用
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void)
    
    /// 页面开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)
    
    /// 页面加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    
    /// 跳转失败的时候调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error)
    
    /// 内容加载失败
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error)
    
    /// 执行JS注入方法
    func webViewUserContentController(_ scriptMessageHandlerArray:[String], didReceive message: WKScriptMessage)
    
    /// JS执行回调方法
    func webViewEvaluateJavaScript(_ result:Any?,error:Error?)
}

public extension WKWebViewDelegate {
    /// 服务器开始请求的时候调用
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void){}
    
    /// 页面开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){}
    
    /// 页面加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){}
    
    /// 跳转失败的时候调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){}
    
    /// 内容加载失败
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error){}
    
    /// 执行JS注入方法
    func webViewUserContentController(_ scriptMessageHandlerArray:[String], didReceive message: WKScriptMessage){}
    
    /// JS执行回调方法
    func webViewEvaluateJavaScript(_ result:Any?,error:Error?){}
}

