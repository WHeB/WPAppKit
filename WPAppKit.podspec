

Pod::Spec.new do |s|
  s.name             = 'WPAppKit'
  s.version          = '0.1.5'
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
      sss.dependency 'Kingfisher'
    end
    
    # MBProgressHUD
    ss.subspec 'MBProgressHUD' do |sss|
      sss.source_files = 'WPAppKit/Classes/ThirdKit/MBProgressHUD/*.{swift,h,m}'
    end
    
  end

  # s.source_files = 'WPAppKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'WPAppKit' => ['WPAppKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
