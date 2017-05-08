# ConfiguRateSDK

## Requirements

- iOS 9.0+
- Xcode 8.1+
- Swift 3.0+

## Installation

### CocoaPods

To integrate ConfiguRateSDK into your Xcode project using [CocoaPods](https://cocoapods.org), add it to your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'ConfiguRateSDK'
end
```

Then, run the following command:

```bash
$ pod install
```

## Usage

1. Import ConfiguRateSDK framework header in your app delegate

    ```swift
    // Swift
    import ConfiguRateSDK
    ```

2. Add the following to your view controller.

	```swift
	// Swift
  let virtualId = "YOUR_VIRTUAL_ID" // Contact [Appable](http://goappable.com/)
	ConfiguRateButton(target: self, virtualId: virtualId)
	```

## License

ConfiguRateSDK is released under the MIT license. [See LICENSE](https://github.com/naviet2308/ConfiguRateSDK/blob/master/LICENSE) for details.
