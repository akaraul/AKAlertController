//
//  AKAlertAnimator.swift
//  piranha
//
//  Created by imac4 on 14/05/2020.
//  Copyright © 2020 AiweApps. All rights reserved.
//

import UIKit
import Foundation

class AKAlertAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let isPresenting: Bool
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
    }
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return isPresenting ? 0.25 : 0.2
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            presentAnimateTransition(transitionContext)
        } else {
            dismissAnimateTransition(transitionContext)
        }
    }
    
    private func presentAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        let alertController = transitionContext.viewController(forKey: .to) as! AKAlertController
        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)
        
        alertController.view.alpha = 0.0
        if alertController.isAlert {
            alertController.containerView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } else {
            alertController.containerView.transform = CGAffineTransform(translationX: 0, y: containerView.bounds.height / 2)
        }
        containerView.addSubview(alertController.view)
        
        UIView.animate(withDuration: duration, animations: {
            alertController.view.alpha = 1.0
            alertController.containerView.transform = .identity
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
    
    private func dismissAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        let alertController = transitionContext.viewController(forKey: .from) as! AKAlertController
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            alertController.overlayView.alpha = 0.0
            if alertController.isAlert {
                alertController.containerView.alpha = 0.0
            } else {
                alertController.containerView.transform = CGAffineTransform(translationX: 0, y: alertController.containerView.frame.height * 1.3)
            }
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
    
}
