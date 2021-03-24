
Pod::Spec.new do |s|
    s.name             = 'WPAppKit'
    s.version          = '1.0.2'
    s.summary          = '搭建 Swift 项目常用类库整合'
    s.description      = <<-DESC
    Cocoa：Foundation,UIKit相关扩展
    Tool：常用工具库
    ThirdKit：常用第三方库
    DESC
    
    s.homepage         = 'https://github.com/WHeB/WPAppKit.git'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'WHeB' => '1193325271@qq.com' }
    s.source           = { :git => 'https://github.com/WHeB/WPAppKit.git', :tag => s.version.to_s }
    s.swift_version = '5.0'
    s.ios.deployment_target = '10.0'
    s.static_framework = true
    
    # ---------------  Cocoa常用扩展  -----------
    s.subspec 'Cocoa' do |ss|
        # Foundation
        ss.subspec 'Foundation' do |sss|
            sss.source_files = 'WPAppKit/Classes/Cocoa/Foundation/*.swift'
        end
        
        # UIKit
        ss.subspec 'UIKit' do |sss|
            sss.source_files = 'WPAppKit/Classes/Cocoa/UIKit/*.swift'
        end
    end
    
    # ---------------  自定义UI  -----------
    s.subspec 'CustomView' do |ss|
        ss.source_files = 'WPAppKit/Classes/CustomView/*.swift'
        ss.frameworks = 'UIKit', 'Foundation'
        ss.dependency 'WPAppKit/Cocoa'
    end
    
    # ---------------  工具库  -----------
    s.subspec 'Tool' do |ss|
        ss.source_files = 'WPAppKit/Classes/Tool/*.swift'
        ss.frameworks = 'UIKit', 'Foundation'
        ss.dependency 'WPAppKit/Cocoa'
    end
    
    # ---------------  弹窗  -----------
    s.subspec 'WPPopupView' do |ss|
        ss.source_files = 'WPAppKit/Classes/WPPopupView/*.swift'
        ss.dependency 'WPAppKit/Tool'
    end
    
    # ---------------  WebView  -----------
    s.subspec 'WPWebView' do |ss|
        ss.ios.framework  = 'WebKit'
        ss.source_files = 'WPAppKit/Classes/WPWebView/*.{swift,html}'
    end
    
    # ---------------  CodeScan  -----------
    s.subspec 'CodeScan' do |ss|
        ss.source_files = 'WPAppKit/Classes/CodeScan/*.swift'
        ss.resource = 'WPAppKit/Assets/CodeScan.bundle'
    end
    
    # ---------------  常用库集成  -----------
    s.subspec 'OftenLib' do |ss|
        ss.dependency 'SnapKit', '~> 5.0.1'
        ss.dependency 'Alamofire', '~> 5.1.0'
        ss.dependency 'Localize-Swift', '~> 2.0'
    end
    
    # ---------------  第三方库 + 扩展  -----------
    s.subspec 'ThirdKit' do |ss|
        # MJRefresh
        ss.subspec 'MJRefresh' do |sss|
            sss.source_files = 'WPAppKit/Classes/ThirdKit/MJRefresh/*.swift'
            sss.dependency 'MJRefresh','3.2.2'
        end
        
        # Kingfisher
        ss.subspec 'Kingfisher' do |sss|
            sss.source_files = 'WPAppKit/Classes/ThirdKit/Kingfisher/*.swift'
            sss.dependency 'Kingfisher','~> 5.10.0'
        end
        
        # MBProgressHUD
        ss.subspec 'MBProgressHUD' do |sss|
            sss.source_files = 'WPAppKit/Classes/ThirdKit/MBProgressHUD/*.{swift,h,m}'
            ss.dependency 'WPAppKit/Cocoa'
        end
        
        # HBDNavigationBar
        ss.subspec 'HBDNavigationBar' do |sss|
            sss.source_files = 'WPAppKit/Classes/ThirdKit/HBDNavigationBar/*.swift'
            sss.dependency 'HBDNavigationBar','~> 1.5.2'
        end
        
    end

end
