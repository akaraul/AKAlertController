# AKAlertController

[![CI Status](https://img.shields.io/travis/akaraul/AKAlertController.svg?style=flat)](https://travis-ci.org/akaraul/AKAlertController)
[![Version](https://img.shields.io/cocoapods/v/AKAlertController.svg?style=flat)](https://cocoapods.org/pods/AKAlertController)
[![License](https://img.shields.io/cocoapods/l/AKAlertController.svg?style=flat)](https://cocoapods.org/pods/AKAlertController)
[![Platform](https://img.shields.io/cocoapods/p/AKAlertController.svg?style=flat)](https://cocoapods.org/pods/AKAlertController)

Simple Alert View written in Swift, which can be used as a UIAlertController replacement.  
It supports from iOS 10! It is simple and easily customizable! 
Supported alerts and action sheets!

![BackgroundImage](../master/Screenshots/alert.png)
![BackgroundImage](../master/Screenshots/actionsheet.png)
![BackgroundImage](../master/Screenshots/textfields.png)

## Easy to use

AKAlertController can be used as a UIAlertController.

#### Alert
```swift
let alertController = AKAlertController(title: "Title label", message: "Message label", preferredStyle: .alert)
let handler: (AKAlertAction) -> Void = { action in print("\(action.title) pressed" )}

alertController.addAction(AKAlertAction(title: "Default action", style: .default, handler: handler))
alertController.addAction(AKAlertAction(title: "Cancel action", style: .cancel, handler: handler))
alertController.addAction(AKAlertAction(title: "Destructive action", style: .destructive, handler: handler))

// add textfield
alertController.addTextFieldWithConfigurationHandler { textField in
  textField.placeholder = "Password"
  textField.secureTextEntry = true
}

present(alertController, animated: true, completion: nil)
```  

#### Action sheet
```swift
let actionSheet = AKAlertController(title: "Title label", message: nil, preferredStyle: .actionSheet)
let handler: (AKAlertAction) -> Void = { action in print("\(action.title) pressed" )}

actionSheet.addAction(AKAlertAction(title: "Default action", style: .default, handler: handler))
actionSheet.addAction(AKAlertAction(title: "Cancel action", style: .cancel, handler: handler))
actionSheet.addAction(AKAlertAction(title: "Destructive action", style: .destructive, handler: handler))

present(actionSheet, animated: true, completion: nil)
``` 
        
## Сustomizable elements

AKAlertControlle completely repeats the system UIAlertController interface, but with the ability to customize:
* Fonts (Text, Buttons)
* Colors (Overlay, Views, Text, Buttons)
* Sizes
* It is possible to add an image

![BackgroundImage](../master/Screenshots/customactionsheet.png)
![BackgroundImage](../master/Screenshots/customalert.png)

#### Customization is available as at the controller level
```swift
var appearance = AKAlertControllerAppearance.defaultAppearance()
appearance.titleFont = .systemFont(ofSize: 22)
appearance.titleTextColor = .purple

let alertController = AKAlertController(title: "Title", message: "Message", preferredStyle: .alert, appearance: appearance)
...
``` 

#### ... so for every action
```swift
...
let cancelAction = AKAlertAction(title: "Cancel", style: .cancel, handler: handler)
cancelAction.bgColor = .black
cancelAction.textColor = .white
cancelAction.icon = UIImage(named: "close")
alertController.addAction(cancelAction)
...
``` 
#### Example with image
```swift
let alertController = AKAlertController(title: "Title label", message: "Message label", headerImage: UIImage(named: "close"), preferredStyle: .alert)
let handler: (AKAlertAction) -> Void = { action in print("\(action.title) pressed" )}
alertController.addAction(AKAlertAction(title: "Default action", style: .default, handler: handler))
alertController.addAction(AKAlertAction(title: "Cancel action", style: .cancel, handler: handler))
alertController.addAction(AKAlertAction(title: "Destructive action", style: .destructive, handler: handler))
present(alertController, animated: true, completion: nil)
``` 
![BackgroundImage](../master/Screenshots/alertimage.png)
![BackgroundImage](../master/Screenshots/sheetimage.png)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
* iOS 10.0+
* Swift 5.0+
* Xcode 11+

## Installation

AKAlertController is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AKAlertController', '~> 1.0.0'
```

## License

AKAlertController is available under the MIT license. See the LICENSE file for more info.
