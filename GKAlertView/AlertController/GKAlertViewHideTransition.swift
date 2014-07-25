//
//  GKAlertViewHideTransition.swift
//  GKAlertView
//
//  Created by Georg Kitz on 24/07/14.
//  Copyright (c) 2014 Aplic GmbH. All rights reserved.
//

import UIKit

class GKAlertViewHideTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning!) -> NSTimeInterval {
        return 0.25
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning!) {
        let fromCtr = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as GKAlertViewController
        let toCtr = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        let bounds = transitionContext.containerView().bounds
        let backgroundView = UIView(frame: bounds)
        backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.55)
        
        transitionContext.containerView().insertSubview(toCtr.view, belowSubview: fromCtr.view)
        transitionContext.containerView().insertSubview(backgroundView, aboveSubview: toCtr.view)
        

        UIView.animateWithDuration(0.25, delay: 0.0, options:UIViewAnimationOptions.CurveLinear, animations: ({
            
            backgroundView.alpha = 0.0
            fromCtr.view.transform = CGAffineTransformMakeRotation(degreesToRadian(5))
            fromCtr.view.frame.origin.y = CGRectGetHeight(transitionContext.containerView().bounds);
            
            }), completion:{(finished: Bool) in
                
                backgroundView.removeFromSuperview()
                fromCtr.view.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                
            });
    }
}
