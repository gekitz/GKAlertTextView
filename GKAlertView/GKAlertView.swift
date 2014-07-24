//
//  GKAlertView.swift
//  GKAlertView
//
//  Created by Georg Kitz on 22/07/14.
//  Copyright (c) 2014 Aplic GmbH. All rights reserved.
//

import UIKit

func degreesToRadian(degree: Double) -> CGFloat{
    let radians:Double =  (degree) / 180.0 * M_PI
    return CGFloat(radians)
}

class GKAlertView: UIView {

    typealias completionClosure = (value: String) -> ()
    var completion: completionClosure {
        set {
            self.contentView.completion = newValue
        }
    
        get {
            return self.contentView.completion!
        }
    }
    
    var shown:Bool = false
    var defaultDismissRotation:CGFloat = degreesToRadian(5)
    
    //Properties
    var presentingWindow: UIWindow? = {
      
        let bounds = UIScreen.mainScreen().bounds
        let presentingWindow = UIWindow(frame: bounds)
        
        return presentingWindow
    }()
    
    let placeholderView: UIView = {
        
        let bounds = UIScreen.mainScreen().bounds
        let placeholderView = UIView(frame: bounds)
        placeholderView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        placeholderView.alpha = 0.0
        
        return placeholderView
    }()
    
    let contentView: GKTextAlertContentView = {
       
        let contentView = NSBundle.mainBundle().loadNibNamed("GKTextAlertContentView", owner: nil, options: nil)[0] as GKTextAlertContentView
        
        return contentView
    }()
    
    var animationCenter: CGPoint = CGPointZero
    
    //MARK: Public
    
    init(frame: CGRect) {
    
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        self.layer.cornerRadius = 4.0
        self.layer.borderColor = UIColor(red: 0.937, green: 0.937, blue: 0.957, alpha: 1.0).CGColor
        self.layer.borderWidth = 1.0
        self.clipsToBounds = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "_dismissAlertView:")
        placeholderView.addGestureRecognizer(gestureRecognizer)
        
        self.contentView.frame = CGRectMake(0, 0, CGRectGetWidth(frame), 1500)
        self.addSubview(self.contentView)
    }
    
    func show(show:Bool) {
        
        if self.shown == show {
            return
        }
        
        self.shown = show
        
        if show {
            
            self._addObservers()
            self._resizeViews()
            
            self.contentView.textField.becomeFirstResponder()
            self.transform = CGAffineTransformMakeRotation(degreesToRadian(-5))
        
            self._preparePresentingWindow()
            self._performShowAnimation()
            
        } else {
            
            self._removeObserver()
            self._performHideAnimation()
    
        }
    }
    
    //MARK: notification methods
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
        let bounds = self.bounds
        let endFrameValue: NSValue = notification.userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue
        let endFrame = endFrameValue.CGRectValue()
        
        self.animationCenter = CGPointMake(CGRectGetMidX(self.presentingWindow!.bounds), CGRectGetMinY(endFrame) / 2)
    }
    
    func _keyboardWillHide(notification: NSNotification) {
        
    }
    
    //MARK: animation methods
    func _performShowAnimation() {
        
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseInOut, animations: ({
            
            self.placeholderView.alpha = 1.0;
            self.center = self.animationCenter
            self.transform = CGAffineTransformIdentity
            
            }), completion:nil)
    }
    
    func _performHideAnimation() {
        UIView.animateWithDuration(0.25, delay: 0.0, options:UIViewAnimationOptions.CurveLinear, animations: ({
            
            self.placeholderView.alpha = 0.0;
            self.transform = CGAffineTransformMakeRotation(self.defaultDismissRotation)
            self.frame.origin.y = CGRectGetHeight(self.presentingWindow!.bounds);
            
            }), completion:{(finished: Bool) in
                
                self.removeFromSuperview()
                self.presentingWindow = nil
                
                if self.contentView.textField.isFirstResponder() {
                    self.contentView.textField.resignFirstResponder()
                }
            });
    }
    
    //MARK: private methods
    func _resizeViews() {
        let size = self.contentView.intrinsicContentSize()
        self.frame = CGRectMake(20, -size.height - 20, size.width, size.height)
        self.contentView.frame = self.bounds
    }
    
    func _preparePresentingWindow() {
        if let presentingWindow = self.presentingWindow? {
            presentingWindow.addSubview(self.placeholderView)
            presentingWindow.addSubview(self)
            presentingWindow.makeKeyAndVisible()
        }
    }
    
    //MARK: Gesture Recognizer
    func _dismissAlertView(gestureRecognizer: UITapGestureRecognizer) {
        
        let point = gestureRecognizer.locationInView(self.placeholderView)
        let center:CGFloat = self.placeholderView.center.x
        
        self.defaultDismissRotation = degreesToRadian(point.x > center ? 5 : -5)
        
        
        self.show(false)
    }
    
}
