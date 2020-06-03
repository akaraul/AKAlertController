#
# Be sure to run `pod lib lint AKAlertController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AKAlertController'
  s.version          = '1.1.0'
  s.swift_versions   = [5.0]
  s.summary          = 'Simple fully customizable UIAlertController written in Swift.'

  s.description      = <<-DESC
                       Simple fully customizable UIAlertController written in Swift. Added the ability to change colors, fonts, etc.
                       DESC

  s.homepage         = 'https://github.com/akaraul/AKAlertController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'akaraul' => 'akaraul@yandex.ru' }
  s.source           = { :git => 'https://github.com/akaraul/AKAlertController.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.cocoapods_version = '>= 1.4.0'
  
  s.source_files = 'AKAlertController/Classes/**/*'
  s.frameworks = 'UIKit'
  s.dependency 'TinyConstraints', '~> 4.0'
  
end
