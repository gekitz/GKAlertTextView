//
//  GKAlertViewShowTransition.swift
//  GKAlertView
//
//  Created by Georg Kitz on 24/07/14.
//  Copyright (c) 2014 Aplic GmbH. All rights reserved.
//

import UIKit

class GKAlertViewShowTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    //MARK: Transition Methods
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning!) -> NSTimeInterval {
        return 0.25
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning!) {
        
        let fromCtr = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toCtr = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as GKAlertViewController
        let bounds = transitionContext.containerView().bounds
        
        self._prepareToController(toCtr)
        
        let snapshotView = self._initializeSnapshotView(fromCtr, bounds: bounds)
        let backgroundView = self._initializeBackgroundView(bounds)
        
        transitionContext.containerView().addSubview(snapshotView)
        transitionContext.containerView().addSubview(backgroundView)
        transitionContext.containerView().addSubview(toCtr.view)
        
        self._animateBackgroundView(backgroundView)
        self._animateControllerInTransitionContext(transitionContext)
        
        self._addGestureRecognizer(backgroundView, withTarget: toCtr)
    }
    
    //MARK: Private
    
    private func _prepareToController(toCtr: GKAlertViewController) {
        
        toCtr.view.frame = CGRectMake(20, -60, 280, 60)
        toCtr.view.layer.cornerRadius = 5
        toCtr.view.transform = CGAffineTransformMakeRotation(degreesToRadian(-5))
    }
    
    private func _initializeSnapshotView(fromCtr:UIViewController, bounds: CGRect) -> (UIView){
        
        let snapshotView = UIImageView(frame: bounds)
        snapshotView.image = UIImage.viewControllerSnapshot(fromCtr)
        
        return snapshotView
    }
    
    private func _initializeBackgroundView(bounds: CGRect) -> (UIView){
        
        let backgroundView = UIView(frame: bounds)
        backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.55)
        backgroundView.alpha = 0.0
        
        return backgroundView
    }
    
    private func _addGestureRecognizer(backgroundView: UIView, withTarget target: AnyObject) {
        
        let gestureRecognizer = UITapGestureRecognizer(target: target, action: "_didTapOutSideController:")
        backgroundView.addGestureRecognizer(gestureRecognizer)
    }
    
    private func _animateControllerInTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        
        let toCtr = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as GKAlertViewController
        let animations: () -> () = {
            toCtr.view.center = transitionContext.containerView().center
            toCtr.view.transform = CGAffineTransformIdentity
        }
        
        let completion: (Bool) -> () = {(finished: Bool) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
        
        UIView.animateWithDuration(1, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 15, options: UIViewAnimationOptions.CurveEaseInOut, animations: animations, completion: completion)
    }
    
    private func _animateBackgroundView(backgroundView: UIView){
        
        let animations = {
            backgroundView.alpha = 1
        }
        
        UIView.animateWithDuration(0.25, animations:animations, completion: nil)
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
