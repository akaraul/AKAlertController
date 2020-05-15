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
    open var title: String
    open var style: AKAlertActionStyle
    open var bgColor: UIColor?
    open var textColor: UIColor?
    open var font: UIFont?
    var handler: ((AKAlertAction) -> Void)?
    
    required public init(title: String, style: AKAlertActionStyle, handler: ((AKAlertAction) -> Void)?) {
        self.title = title
        self.style = style
        self.handler = handler
    }
    
}
