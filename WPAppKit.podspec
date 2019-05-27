#
# Be sure to run `pod lib lint WPAppKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WPAppKit'
  s.version          = '0.1.2'
  s.summary          = '搭建 Swift 项目常用类库整合'
  s.description      = <<-DESC
      Cocoa：Foundation,UIKit相关扩展
      Tool：常用工具库
      ThirdKit：常用第三方库
                       DESC

  s.homepage         = 'https://github.com/WHeB/WPAppKit.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'WHeB' => '1193325271@qq.com' }
  s.source           = { :git => 'https://github.com/WHeB/WPAppKit.git', :tag => s.version.to_s }
  s.swift_version = '4.0'
  s.ios.deployment_target = '9.0'


  # ---------------  Cocoa常用扩展  -----------
  s.subspec 'Cocoa' do |ss|
    ss.source_files = 'WPAppKit/Classes/Cocoa/**/*.swift'
    ss.frameworks = 'UIKit', 'Foundation'
  end
  
  # ---------------  工具库  -----------
  s.subspec 'Tool' do |ss|
    ss.source_files = 'WPAppKit/Classes/Tool/*.swift'
    ss.frameworks = 'UIKit', 'Foundation'
  end

  # ---------------  第三方库 + 扩展  -----------
  s.subspec 'ThirdKit' do |ss|
    
    # Kingfisher
    ss.subspec 'Kingfisher' do |sss|
      sss.source_files = 'WPAppKit/Classes/ThirdKit/Kingfisher/*.swift'
      sss.dependency 'Kingfisher'
    end
    
    # MBProgressHUD
    ss.subspec 'ZHRefresh' do |sss|
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
