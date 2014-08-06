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
    
    var animationCenter: CGPoint = CGPointZero
    var bounds: CGRect = CGRectZero
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning!) -> NSTimeInterval {
        return 0.25
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning!) {
        
        self._addObservers()
        
        let fromCtr = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toCtr = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        self.bounds = transitionContext.containerView().bounds
        self.animationCenter = transitionContext.containerView().center
        
        self._prepareToController(toCtr)
        
        let snapshotView = self._initializeSnapshotView(fromCtr)
        let backgroundView = self._initializeBackgroundView()
        
        transitionContext.containerView().addSubview(snapshotView)
        transitionContext.containerView().addSubview(backgroundView)
        transitionContext.containerView().addSubview(toCtr.view)
        
        self._animateBackgroundView(backgroundView)
        self._animateControllerInTransitionContext(transitionContext, snapshot: snapshotView, background: backgroundView)
        
        self._addGestureRecognizer(backgroundView, withTarget: toCtr)
    }
    
    //MARK: Private
    
    private func _prepareToController(toCtr: UIViewController) {
        let size: CGSize = toCtr.view.intrinsicContentSize()
        toCtr.view.frame = CGRectMake(20, -size.height - 10, 280, size.height)
        toCtr.view.layer.cornerRadius = 5
        toCtr.view.transform = CGAffineTransformMakeRotation(degreesToRadian(-5))
    }
    
    private func _initializeSnapshotView(fromCtr:UIViewController) -> (UIView){
        
        let snapshotView = UIImageView(frame: self.bounds)
        snapshotView.image = UIImage.viewControllerSnapshot(fromCtr)
        snapshotView.tag = 88
        
        return snapshotView
    }
    
    private func _initializeBackgroundView() -> (UIView){
        
        let backgroundView = UIView(frame: self.bounds)
        backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.55)
        backgroundView.alpha = 0.0
        backgroundView.tag = 77
        
        return backgroundView
    }
    
    private func _addGestureRecognizer(backgroundView: UIView, withTarget target: AnyObject) {
        
        let gestureRecognizer = UITapGestureRecognizer(target: target, action: "_didTapOutSideController:")
        backgroundView.addGestureRecognizer(gestureRecognizer)
    }
    
    private func _animateControllerInTransitionContext(transitionContext: UIViewControllerContextTransitioning, snapshot: UIView, background: UIView) {
        
        let toCtr = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as GKAlertViewController
        let animations: () -> () = {
            toCtr.view.center = self.animationCenter
            toCtr.view.transform = CGAffineTransformIdentity
        }
        
        let completion: (Bool) -> () = {(finished: Bool) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            
            if let superview = toCtr.view.superview? {
            
                superview.insertSubview(background, atIndex: 0)
                superview.insertSubview(snapshot, atIndex: 0)
            }
        }
        
        UIView.animateWithDuration(1, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 15, options: UIViewAnimationOptions.CurveEaseInOut, animations: animations, completion: completion)
    }
    
    private func _animateBackgroundView(backgroundView: UIView){
        
        let animations = {
            backgroundView.alpha = 1
        }
        
        UIView.animateWithDuration(0.25, animations:animations, completion: nil)
    }
    
    //MARK: Notifications
    
    func _addObservers() {
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector:"_keyboardWillShow:" , name: UIKeyboardWillShowNotification, object: nil)
        center.addObserver(self, selector:"_keyboardWillHide:" , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func _removeObserver() {
        let center = NSNotificationCenter.defaultCenter()
        center.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        center.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func _keyboardWillShow(notification: NSNotification) {

        let endFrameValue: NSValue = notification.userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue
        let endFrame = endFrameValue.CGRectValue()
        
        self.animationCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMinY(endFrame) / 2)
    }
    
    func _keyboardWillHide(notification: NSNotification) {
        
    }
    
    //MARK: Deinitialize
    deinit {
        self._removeObserver()
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
