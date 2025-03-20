#
# Be sure to run `pod lib lint DooPaymentMobileSdk.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DooPaymentMobileSdk'
  s.version          = '1.0.2'
  s.summary          = 'Integrate Doo Payment Gateway SDK to your iOS app'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://developer.doopayment.com'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Novice.Cai' => 'jayshidai@163.com' }
  s.source           = { :git => 'https://github.com/jayshidai/DooPaymentMobileSdk.git', :tag => s.version }
  s.ios.vendored_frameworks = 'DooPaymentMobileSdk.xcframework'
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.4'
  s.swift_version = '5.0'
  #s.source_files = 'DooPaymentMobileSdk/Classes/**/*.{swift,h,m,mm}'
  
  # s.resource_bundles = {
  #   'DooPaymentMobileSdk' => ['DooPaymentMobileSdk/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'hyperswitch-sdk-ios', '~> 0.2.3'
  s.dependency 'hyperswitch-sdk-ios/scancard', '~> 0.2.3'
  s.dependency 'hyperswitch-sdk-ios/netcetera3ds', '~> 0.2.3'
  s.user_target_xcconfig = { 'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES' }
  s.pod_target_xcconfig = { 'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES' }
  
end
