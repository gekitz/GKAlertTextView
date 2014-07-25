//
//  GKAlertViewShowTransition.swift
//  GKAlertView
//
//  Created by Georg Kitz on 24/07/14.
//  Copyright (c) 2014 Aplic GmbH. All rights reserved.
//

import UIKit

class GKAlertViewShowTransition: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning!) -> NSTimeInterval {
        return 0.25
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning!) {
        let fromCtr = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toCtr = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as GKAlertViewController
        
        toCtr.backgroundImage = UIImage.viewControllerSnapshot(fromCtr)
        
        toCtr.view.bounds = transitionContext.containerView().bounds
        toCtr.view.alpha = 0.0
        
        transitionContext.containerView().addSubview(toCtr.view)
        
        UIView.animateWithDuration(0.25, animations: ({
            
            toCtr.view.alpha = 1
            
            }), completion: ({(finished: Bool) in
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                
                }))
    }
}

extension UIImage {
    class func viewControllerSnapshot(controller: UIViewController) -> UIImage {
        let bounds = controller.view.bounds
        
        UIGraphicsBeginImageContext(bounds.size)
        [controller.view .drawViewHierarchyInRect(bounds, afterScreenUpdates: false)]
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
