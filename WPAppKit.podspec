#
# Be sure to run `pod lib lint WPAppKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WPAppKit'
  s.version          = '0.1.0'
  s.summary          = '搭建 Swift 项目常用类库整合'
  s.description      = <<-DESC
      Cocoa：Foundation,UIKit相关扩展 
                       DESC

  s.homepage         = 'https://github.com/WHeB/WPAppKit.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'WHeB' => '1193325271@qq.com' }
  s.source           = { :git => 'https://github.com/WHeB/WPAppKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'


  # ---------------  Cocoa常用扩展  -----------
  s.subspec 'Cocoa' do |ss|
    ss.source_files = 'WPAppKit/Classes/Cocoa/**/*.swift'

    ss.frameworks = 'UIKit', 'Foundation'
  end


  # s.source_files = 'WPAppKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'WPAppKit' => ['WPAppKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
