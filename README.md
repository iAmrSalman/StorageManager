# StorageManager

[![CI Status](http://img.shields.io/travis/iAmrSalman/StorageManager.svg?style=flat)](https://travis-ci.org/iAmrSalman/StorageManager)
[![Version](https://img.shields.io/cocoapods/v/StorageManager.svg?style=flat)](http://cocoapods.org/pods/StorageManager)
[![License](https://img.shields.io/cocoapods/l/StorageManager.svg?style=flat)](http://cocoapods.org/pods/StorageManager)
[![Platform](https://img.shields.io/cocoapods/p/StorageManager.svg?style=flat)](http://cocoapods.org/pods/StorageManager)

![banner](https://user-images.githubusercontent.com/10261166/35454139-80ddfb16-02d5-11e8-90f6-3ca183590728.png)

FileManager framework that handels Store, fetch, delete and update files in local storage.

## Requirements

- iOS 8.0+ / macOS 10.10+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 10.2+
- Swift 5.0+

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

### Store

##### *Dictionary*: 

```swift
let exampleDictionary = ["foo": "bar", "x": 3, "pi": 3.1415, "names": ["Amr", "Salman"]]

try! StorageManager.default.store(dictionary: exampleDictionary, in: "exampleDictionary")
```

##### *Array*:

```swift
let exampleArray = ["foo", "bar", "x", "y"]

try! StorageManager.default.store(dictionary: exampleArray, in: "exampleArray")
```

##### *Data*:

```swift
let exampleData = Data()

try! StorageManager.default.store(data: exampleData, jsonType: .array, in: "exampleData")
```

### Update

```swift
let newX = 5

try! StorageManager.default.update(vlaue: newX, forKey: "x", in: "exampleDictionary")
```

### Delete

```swift
try! StorageManager.default.clear("exampleData")
```

### Fetch

##### *Single value*

```swift
let x: Int = try! StorageManager.default.singleValue(forKey: "x", in: "exampleDictionary")
```

##### *Array*

```swift
let exampleArray: [String] = try! StorageManager.default.arrayValue("exampleArray")
```

##### *Array as value for key*

```swift
let names: [String] = try! StorageManager.default.arrayValue(forKey: "names", in: "exampleDictionary")
```

##### *Dictionary*

```swift
let exampleDictionary: [String: Any] = try! StorageManager.default.dictionaryValue("exampleDictionary")
```


## Author

Amr Salman, iamrsalman@gmail.com

## License

StorageManager is available under the MIT license. See the LICENSE file for more info.
