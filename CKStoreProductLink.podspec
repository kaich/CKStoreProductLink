#
# Be sure to run `pod lib lint CKStoreProductLink.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CKStoreProductLink'
  s.version          = '0.1.2'
  s.summary          = 'Simple way to show app in app store.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Simple way to show app in app store.
                       DESC

  s.homepage         = 'https://github.com/kaich/CKStoreProductLink'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kaich' => 'chengkai1853@163.com' }
  s.source           = { :git => 'https://github.com/kaich/CKStoreProductLink.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.default_subspec = 'Both'

  s.subspec 'Both' do |sb|
    sb.source_files = 'CKStoreProductLink/Classes/**/*'
    sb.frameworks = 'UIKit', 'StoreKit' 
  end

  s.subspec 'Outer' do |so|
    so.source_files = 'CKStoreProductLink/Classes/**/CKStoreProductLink.swift'
    so.frameworks = 'Foundation'
  end
  
  # s.resource_bundles = {
  #   'CKStoreProductLink' => ['CKStoreProductLink/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.dependency 'AFNetworking', '~> 2.3'
end
