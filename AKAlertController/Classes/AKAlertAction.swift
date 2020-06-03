//
//  AKAlertAction.swift
//  piranha
//
//  Created by imac4 on 14/05/2020.
//  Copyright © 2020 AiweApps. All rights reserved.
//

import UIKit
import Foundation

public enum AKAlertActionStyle: Int {
    case destructive
    case `default`
    case cancel
}

open class AKAlertAction {
    
    public let title: String
    public let style: AKAlertActionStyle
    public let handler: ((AKAlertAction) -> Void)?
    
    /// Background color for this action button only (regardless of general settings)
    open var bgColor: UIColor?
    /// Highlighted background color for this action button only (regardless of general settings)
    open var highlightedBgColor: UIColor?
    /// Text color for this action button only (regardless of general settings)
    open var textColor: UIColor?
    /// Font for this action button only (regardless of general settings)
    open var font: UIFont?
    /// Image for action
    open var icon: UIImage?
    
    required public init(title: String, style: AKAlertActionStyle, handler: ((AKAlertAction) -> Void)?) {
        self.title = title
        self.style = style
        self.handler = handler
    }
    
}

class AKAlertActionButton: UIButton {
    
    private var highlightedColor: UIColor?
    private var bgColor: UIColor?
    
    var isHighlightedState: Bool = false {
        didSet {
            backgroundColor = isHighlightedState ? highlightedColor : bgColor
        }
    }
    
    func setupForAction(_ action: AKAlertAction, withAppearance appearance: AKAlertControllerAppearance) {
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.minimumScaleFactor = 0.5
        contentEdgeInsets = appearance.buttonsContentEdgeInsets
        imageEdgeInsets = appearance.buttonsImageEdgeInsets
        setTitle(action.title, for: .normal)
        setImage(action.icon, for: .normal)
        titleLabel?.font = action.font ?? appearance.buttonFont[action.style]
        setTitleColor(action.textColor ?? appearance.buttonTextColor[action.style], for: .normal)
        backgroundColor = action.bgColor ?? appearance.buttonBgColor[action.style]
        
        bgColor = backgroundColor
        highlightedColor = action.highlightedBgColor ?? appearance.highlightedButtonsBgColor ?? bgColor?.withAlphaComponent(0.5)
    }
    
}
