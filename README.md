# StorageManager

[![CI Status](http://img.shields.io/travis/iAmrSalman/StorageManager.svg?style=flat)](https://travis-ci.org/iAmrSalman/StorageManager)
[![Version](https://img.shields.io/cocoapods/v/StorageManager.svg?style=flat)](http://cocoapods.org/pods/StorageManager)
[![License](https://img.shields.io/cocoapods/l/StorageManager.svg?style=flat)](http://cocoapods.org/pods/StorageManager)
[![Platform](https://img.shields.io/cocoapods/p/StorageManager.svg?style=flat)](http://cocoapods.org/pods/StorageManager)

![banner](https://user-images.githubusercontent.com/10261166/35454139-80ddfb16-02d5-11e8-90f6-3ca183590728.png)

FileManager framework that handels Store, fetch, delete and update files in local storage.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 8.0+ / macOS 10.10+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 9.0+
- Swift 4.0+

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1+ is required to build StorageManager.

To integrate StorageManager into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'StorageManager'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate StorageManager into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "iAmrSalman/StorageManager" ~> 0.1.2
```

Run `carthage update` to build the framework and drag the built `StorageManager.framework` into your Xcode project.

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but StorageManager does support its use on supported platforms. 

Once you have your Swift package set up, adding StorageManager as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/iAmrSalman/StorageManager.git", from: "0.1.2")
]
```

## Usage



## Author

Amr Salman, iamrsalman@gmail.com

## License

StorageManager is available under the MIT license. See the LICENSE file for more info.
