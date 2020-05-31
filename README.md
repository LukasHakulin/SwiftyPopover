# SwiftyPopover

Pure Swift implementation of Popover without limitations of UIPopoverController OR UIPopoverPresentationController.

Simple implementation (2 files) of classic Popover well known from iOS Apps. From time to time we need display some short info connected to view on screen or as context menu. Standard implementation based on `UIPopoverPresentationController` is hard to customize and Swifty Popover was created as answer to that issue.

[![Version](https://img.shields.io/cocoapods/v/SwiftyPopover.svg?style=flat)](https://cocoapods.org/pods/SwiftyPopover)
[![License](https://img.shields.io/cocoapods/l/SwiftyPopover.svg?style=flat)](https://cocoapods.org/pods/SwiftyPopover)
[![Platform](https://img.shields.io/cocoapods/p/SwiftyPopover.svg?style=flat)](https://cocoapods.org/pods/SwiftyPopover)

![](/ScreenShots/SwiftyPopover.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Benefits:

- [x] easy to use
- [x] simple way to customize your solution
- [x] based on UIViewController and UIConstraints

## *Limitations: (known issues)

- no handle device rotation
- missing automatic dismiss when app entering background

## ⚠️ Requirements
 
 - iOS 10.0+
 - Swift 5.+
 - Xcode 11.4.1+

## Installation

SwiftyPopover is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftyPopover'
```

## Author

Lukas Hakulin, l.hakulin@gmail.com

## License

SwiftyPopover is available under the MIT license. See the LICENSE file for more info.
