//
//  AKAlertAnimator.swift
//  piranha
//
//  Created by imac4 on 14/05/2020.
//  Copyright © 2020 AiweApps. All rights reserved.
//

import UIKit
import Foundation

open class AKAlertAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let isPresenting: Bool
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
    }
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return isPresenting ? 0.45 : 0.3
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            presentAnimateTransition(transitionContext)
        } else {
            dismissAnimateTransition(transitionContext)
        }
    }
    
    func presentAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        let alertController = transitionContext.viewController(forKey: .to) as! AKAlertController
        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext) / 2
        
        alertController.overlayView.alpha = 0.0
        alertController.containerView.alpha = 0.0
        if alertController.isAlert {
            alertController.containerView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        } else {
            alertController.containerView.transform = CGAffineTransform(translationX: 0, y: containerView.bounds.height / 2)
        }
        containerView.addSubview(alertController.view)
        
        UIView.animate(withDuration: duration, animations: {
            alertController.overlayView.alpha = 1.0
            alertController.containerView.alpha = 1.0
            if alertController.isAlert {
                alertController.containerView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            } else {
                alertController.containerView.transform = CGAffineTransform(translationX: 0, y: 0)
            }
        }, completion: { _ in
            UIView.animate(withDuration: duration, animations: {
                alertController.containerView.transform = .identity
            }, completion: { finished in
                transitionContext.completeTransition(finished)
            })
        })
    }
    
    func dismissAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        let alertController = transitionContext.viewController(forKey: .from) as! AKAlertController
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            alertController.overlayView.alpha = 0.0
            if alertController.isAlert {
                alertController.containerView.alpha = 0.0
                alertController.containerView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            } else {
                alertController.containerView.transform = CGAffineTransform(translationX: 0, y: alertController.view.frame.height)
            }
        }, completion: { finished in
            transitionContext.completeTransition(finished)
        })
    }
}
