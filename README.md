# IPDecimalNumberPad

[![CI Status](http://img.shields.io/travis/Nick Servidio/IPDecimalNumberPad.svg?style=flat)](https://travis-ci.org/Nick Servidio/IPDecimalNumberPad)
[![Version](https://img.shields.io/cocoapods/v/IPDecimalNumberPad.svg?style=flat)](http://cocoapods.org/pods/IPDecimalNumberPad)
[![License](https://img.shields.io/cocoapods/l/IPDecimalNumberPad.svg?style=flat)](http://cocoapods.org/pods/IPDecimalNumberPad)
[![Platform](https://img.shields.io/cocoapods/p/IPDecimalNumberPad.svg?style=flat)](http://cocoapods.org/pods/IPDecimalNumberPad)

## Usage

Many apps require a user to enter in a decimal value with a number pad. Oftentimes this is accomplished with a keyboard. However, displaying number pad within your UI can also provide a enjoyable user experience. One particularly common use case is the need for users to enter an amount of currency into an app.

The classes provided in this pod provide a quick way to introduce a number pad into your app. For those who want to get started immediately, use the `IPDecimalNumberPadController`. This class includes a number pad and an accompanying label that displays the value entered as US dollars. 

You can change the display of this class by hiding the `amountLabel` property and overriding the method:

```objc
- (void)handleCurrentAmountUpdate:(NSString *)currentAmount
```

You can then update a different UILabel or another element that displays text. You can adjust the insets surrounding the number pad to reposition it within the IPDecimalNumberPadController.

You can also customize the IPDecimalNumberPad itself. You can assign a value to the number pad’s `buttonClass` property. The number pad will then use this class to instantiate the buttons included in its UI. You can also provide a `rowDividerImage`, `columnDividerImage`, and `deleteButtonImage`. The IPDecimalNumberPad automatically creates resizable images from the row and column divider images that you supply.

For those looking for complete customization, you can use the IPDecimalNumberPad in your own UIViewController subclass. You can use the included `IPStringBackedDecimalValue` to hold the current value entered into the number pad, or create your own model. 

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

IPDecimalNumberPad is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "IPDecimalNumberPad"
```

## Author

Nick Servidio, servidionicholas@gmail.com

## License

IPDecimalNumberPad is available under the MIT license. See the LICENSE file for more info.
