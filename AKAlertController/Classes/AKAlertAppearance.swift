//
//  AKAlertAppearance.swift
//  AKAlertController
//
//  Created by Andrey Karaulov on 17.05.2020.
//

import Foundation

public struct AKAlertControllerAppearance {
    
    var alertViewWidth: CGFloat = 270.0
    var alertContainerBgColor: UIColor = .clear
    
    var overlayColor = UIColor.black.withAlphaComponent(0.5)
    var alertBgColor = UIColor.systemWhiteColor
    var alertCornerRadius: CGFloat = 10
    var textMargins: UIEdgeInsets = .uniform(15)
    var titleBottomOffset: CGFloat = 5
    
    var textFieldsMargins: UIEdgeInsets = .init(top: 0, left: 15, bottom: 15, right: 15)
    var textFieldsSpacing: CGFloat = 2
    var textFieldsHeight: CGFloat = 32
    var textFieldsContainerBgColor: UIColor = UIColor.systemWhiteColor
    
    var titleFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
    var titleTextColor = UIColor.systemBlackColor
    var messageFont = UIFont.systemFont(ofSize: 13)
    var messageTextColor = UIColor.systemBlackColor
    var textContainerBgColor = UIColor.systemWhiteColor
    
    var alertButtonsHeight: CGFloat = 44
    var actionSheetButtonsHeight: CGFloat = 56
    var buttonsBordersWidth: CGFloat = 1
    var buttonsBordersColor: UIColor = UIColor.lightGray.withAlphaComponent(0.5)
    
    var buttonFont: [AKAlertActionStyle: UIFont] = [
        .default: UIFont.systemFont(ofSize: 17),
        .cancel: UIFont.systemFont(ofSize: 17, weight: .semibold),
        .destructive: UIFont.systemFont(ofSize: 17)
    ]
    var buttonTextColor: [AKAlertActionStyle: UIColor] = [
        .default: UIColor.systemBlue,
        .cancel: UIColor.systemBlue,
        .destructive: UIColor.systemRed
    ]
    var buttonBgColor: [AKAlertActionStyle : UIColor] = [
        .default: UIColor.systemWhiteColor,
        .cancel: UIColor.systemWhiteColor,
        .destructive: UIColor.systemWhiteColor
    ]
    
    public static func defaultAppearance() -> AKAlertControllerAppearance {
        return AKAlertControllerAppearance()
    }
    
}
