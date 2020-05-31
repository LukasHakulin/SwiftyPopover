#
# Be sure to run `pod lib lint SwiftyPopover.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftyPopover'
  s.version          = '1.0.0'
  s.summary          = 'Pure Swift implementation of Popover without limitations of UIPopoverController OR UIPopoverPresentationController.'
  s.description      = <<-DESC
                         Simple implementation (2 files) of classic Popover well known from iOS Apps.
                         From time to time we need display some short info connected to view on screen or as context menu.
                         Standard implementation based on `UIPopoverPresentationController` is hard to customize
                         and Swifty Popover was created as answer to that issue.
                       DESC
  s.screenshot       = 'https://raw.githubusercontent.com/LukasHakulin/SwiftyPopover/master/ScreenShots/SwiftyPopover.gif'
  s.homepage         = 'https://github.com/LukasHakulin/SwiftyPopover'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.authors          = { 'Lukas Hakulin' => 'l.hakulin@gmail.com' }
  s.source           = { :git => 'https://github.com/LukasHakulin/SwiftyPopover.git', :tag => s.version }
  s.platform         = :ios, '10.0'
  s.requires_arc     = true

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.source_files = 'SwiftyPopover/Classes/**/*'
end
