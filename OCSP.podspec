#
# Be sure to run `pod lib lint OCSP.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OCSP'
  s.version          = '0.2.0'
  s.summary          = 'OCSP to Apple for ObjC.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Check *.p12 & *.mobileprovision file validation.
                       DESC

  s.homepage         = 'https://github.com/Magic-Unique/OCSP'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '冷秋' => '516563564@qq.com' }
  s.source           = { :git => 'https://github.com/Magic-Unique/OCSP.git', :tag => "#{s.version}" }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'

  s.source_files = 'OCSP/Classes/**/*'
  
  # s.resource_bundles = {
  #   'OCSP' => ['OCSP/Assets/*.png']
  # }

  s.public_header_files = 'OCSP/Classes/Public/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
