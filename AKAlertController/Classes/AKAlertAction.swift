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
