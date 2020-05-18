//
//  AKAlertAppearance.swift
//  AKAlertController
//
//  Created by Andrey Karaulov on 17.05.2020.
//

import Foundation

public struct AKAlertControllerAppearance {
    
    /// Alert width constant, used only for AKAlertControllerStyleAlert controller style
    public var alertViewWidth: CGFloat = 270.0
    /// Alert action button height constant
    public var alertButtonsHeight: CGFloat = 44
    /// Action sheet action button height constant
    public var actionSheetButtonsHeight: CGFloat = 56
    /// Action sheet width multiplier constant (max width of action sheet)
    public var actionSheetWidthMultiplier: CGFloat = 0.95
    /// The color of the container background (may not be noticeable when changing, since there are many other containers on top of it)
    public var alertContainerBgColor: UIColor = UIColor.systemWhiteColor
    /// The color of the main content container background (may not be noticeable when changing, since there are many other containers on top of it)
    public var mainContentContainerBgColor: UIColor = UIColor.systemWhiteColor
    
    /// Header image top offset
    public var headerImageTopOffset: CGFloat = 15
    /// Header image max height
    public var headerMaxHeight: CGFloat?
    
    /// Overlay background color
    public var overlayColor = UIColor.black.withAlphaComponent(0.5)
    /// Main content container background color (may not be noticeable when changing, since there are many other containers on top of it)
    public var alertBgColor = UIColor.systemWhiteColor
    /// Alert container corner radius (also used for cancel action sheet button)
    public var alertCornerRadius: CGFloat = 10
    /// Text container margins
    public var textMargins: UIEdgeInsets = .uniform(15)
    /// Title indent from message
    public var titleBottomOffset: CGFloat = 5
    
    /// Text fields container margins
    public var textFieldsMargins: UIEdgeInsets = .init(top: 0, left: 15, bottom: 15, right: 15)
    /// Indent between multiple textfields
    public var textFieldsSpacing: CGFloat = 2
    /// Text fields height
    public var textFieldsHeight: CGFloat = 32
    /// Text fields container background color
    public var textFieldsContainerBgColor: UIColor = UIColor.systemWhiteColor
    
    /// Title font
    public var titleFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
    /// Title color
    public var titleTextColor = UIColor.systemBlackColor
    /// Message font
    public var messageFont = UIFont.systemFont(ofSize: 13)
    /// Message color
    public var messageTextColor = UIColor.systemBlackColor
    /// Text container background color
    public var textContainerBgColor = UIColor.systemWhiteColor
    
    /// Action buttons content edge insets
    public var buttonsContentEdgeInsets: UIEdgeInsets = .uniform(6)
    /// Action buttons image edge insets
    public var buttonsImageEdgeInsets: UIEdgeInsets = .right(6)
    /// Action buttons borders width
    public var buttonsBordersWidth: CGFloat = 1
    /// Action buttons borders color
    public var buttonsBordersColor: UIColor = UIColor.lightGray
    
    /// Font used for all buttons with the specified AKAlertActionStyle type
    public var buttonFont: [AKAlertActionStyle: UIFont] = [
        .default: UIFont.systemFont(ofSize: 17),
        .cancel: UIFont.systemFont(ofSize: 17, weight: .semibold),
        .destructive: UIFont.systemFont(ofSize: 17)
    ]
    /// Text color used for all buttons with the specified AKAlertActionStyle type
    public var buttonTextColor: [AKAlertActionStyle: UIColor] = [
        .default: UIColor.systemBlue,
        .cancel: UIColor.systemBlue,
        .destructive: UIColor.systemRed
    ]
    /// Background color used for all buttons with the specified AKAlertActionStyle type
    public var buttonBgColor: [AKAlertActionStyle : UIColor] = [
        .default: UIColor.systemWhiteColor,
        .cancel: UIColor.systemWhiteColor,
        .destructive: UIColor.systemWhiteColor
    ]
    
    /// Build default AKAlertControllerAppearance
    public static func defaultAppearance() -> AKAlertControllerAppearance {
        return AKAlertControllerAppearance()
    }
    
}
