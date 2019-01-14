#
# Be sure to run `pod lib lint WWBase.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DTTableViewTool'
  s.version          = '0.0.3'
  s.summary          = 'DTTableViewTool is tool lib.'
  s.description      = <<-DESC
    DTTableViewTool is tool lib to use
                       DESC

  s.homepage         = 'https://github.com/IDwangluting/DTTableViewTool'
  s.license = "Copyright (c) 2018年 wangluitng. All rights reserved."
  s.author           = { 'IDwangluting' => 'm13051699286@163.com' }
  s.source           = { :git => 'https://github.com/IDwangluting/DTTableViewTool.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'

  s.ios.deployment_target = '8.0'
  s.source_files = 'DTTableViewTool/Classes/**/*'
  s.frameworks = 'UIKit'

end
