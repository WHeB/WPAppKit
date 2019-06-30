

Pod::Spec.new do |s|
    s.name             = 'WPAppKit'
    s.version          = '0.2.1'
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
    s.swift_version = '4.0'
    s.ios.deployment_target = '9.0'
    s.static_framework = true
    # 集成的库
    s.dependency 'SnapKit', '~> 4.0.0'
    
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
    
    # ---------------  工具库  -----------
    s.subspec 'Tool' do |ss|
        ss.source_files = 'WPAppKit/Classes/Tool/*.swift'
        ss.frameworks = 'UIKit', 'Foundation'
    end
    
    # ---------------  空页面  -----------
    s.subspec 'WPEmptyView' do |ss|
        ss.source_files = 'WPAppKit/Classes/WPEmptyView/*.swift'
    end
    
    # ---------------  WebView  -----------
    s.subspec 'WPWebView' do |ss|
        ss.source_files = 'WPAppKit/Classes/WPWebView/*.{swift,html}'
    end
    
    # ---------------  CTMediator  -----------
    s.subspec 'CTMediator' do |ss|
        ss.source_files = 'WPAppKit/Classes/CTMediator/*.{h,m}'
    end
    
    # ---------------  开放SDK  -----------
    s.subspec 'OpenSDK' do |ss|
        # UM
        ss.subspec 'UM' do |sss|
            sss.source_files = 'WPAppKit/Classes/OpenSDK/UM/*.swift'
            sss.vendored_frameworks = 'WPAppKit/Classes/OpenSDK/UM/*.framework', 'WPAppKit/Classes/OpenSDK/UM/UMSocialUI/*.framework'
            sss.vendored_libraries = 'WPAppKit/Classes/OpenSDK/UM/SocialLibraries/**/*.a'
            sss.resource = 'WPAppKit/Classes/OpenSDK/UM/UMSocialUI/*.bundle'
            sss.frameworks = 'UIKit', 'CoreGraphics'
            sss.libraries = 'sqlite3'
            sss.pod_target_xcconfig = {
                'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/WPAppKit/Classes/OpenSDK/UM/**/*.framework/Headers',
                'LD_RUNPATH_SEARCH_PATHS' => '$(PODS_ROOT)/WPAppKit/Classes/OpenSDK/UM/',
                'OTHER_LDFLAGS' => '-ObjC',
            }
        end
        
    end
    
    # ---------------  第三方库 + 扩展  -----------
    s.subspec 'ThirdKit' do |ss|
        # MJRefresh
        ss.subspec 'MJRefresh' do |sss|
            sss.source_files = 'WPAppKit/Classes/ThirdKit/MJRefresh/*.swift'
            sss.dependency 'MJRefresh'
        end
        
        # Kingfisher
        ss.subspec 'Kingfisher' do |sss|
            sss.source_files = 'WPAppKit/Classes/ThirdKit/Kingfisher/*.swift'
            sss.dependency 'Kingfisher','~> 4.6.0'
        end
        
        # MBProgressHUD
        ss.subspec 'MBProgressHUD' do |sss|
            sss.source_files = 'WPAppKit/Classes/ThirdKit/MBProgressHUD/*.{swift,h,m}'
        end
    end

end
