//
//  AKAlertAppearance.swift
//  AKAlertController
//
//  Created by Andrey Karaulov on 17.05.2020.
//

import Foundation

public struct AKAlertControllerAppearance {
    
    public var alertViewWidth: CGFloat = 270.0
    public var alertContainerBgColor: UIColor = .clear
    
    public var overlayColor = UIColor.black.withAlphaComponent(0.5)
    public var alertBgColor = UIColor.systemWhiteColor
    public var alertCornerRadius: CGFloat = 10
    public var textMargins: UIEdgeInsets = .uniform(15)
    public var titleBottomOffset: CGFloat = 5
    
    public var textFieldsMargins: UIEdgeInsets = .init(top: 0, left: 15, bottom: 15, right: 15)
    public var textFieldsSpacing: CGFloat = 2
    public var textFieldsHeight: CGFloat = 32
    public var textFieldsContainerBgColor: UIColor = UIColor.systemWhiteColor
    
    public var titleFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
    public var titleTextColor = UIColor.systemBlackColor
    public var messageFont = UIFont.systemFont(ofSize: 13)
    public var messageTextColor = UIColor.systemBlackColor
    public var textContainerBgColor = UIColor.systemWhiteColor
    
    public var alertButtonsHeight: CGFloat = 44
    public var actionSheetButtonsHeight: CGFloat = 56
    public var buttonsContentEdgeInsets: UIEdgeInsets = .uniform(6)
    public var buttonsImageEdgeInsets: UIEdgeInsets = .right(6)
    public var buttonsBordersWidth: CGFloat = 1
    public var buttonsBordersColor: UIColor = UIColor.lightGray.withAlphaComponent(0.5)
    
    public var buttonFont: [AKAlertActionStyle: UIFont] = [
        .default: UIFont.systemFont(ofSize: 17),
        .cancel: UIFont.systemFont(ofSize: 17, weight: .semibold),
        .destructive: UIFont.systemFont(ofSize: 17)
    ]
    public var buttonTextColor: [AKAlertActionStyle: UIColor] = [
        .default: UIColor.systemBlue,
        .cancel: UIColor.systemBlue,
        .destructive: UIColor.systemRed
    ]
    public var buttonBgColor: [AKAlertActionStyle : UIColor] = [
        .default: UIColor.systemWhiteColor,
        .cancel: UIColor.systemWhiteColor,
        .destructive: UIColor.systemWhiteColor
    ]
    
    public static func defaultAppearance() -> AKAlertControllerAppearance {
        return AKAlertControllerAppearance()
    }
    
}
