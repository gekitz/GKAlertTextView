//
//  GKAlertViewController.swift
//  GKAlertView
//
//  Created by Georg Kitz on 24/07/14.
//  Copyright (c) 2014 Aplic GmbH. All rights reserved.
//

import UIKit

class GKAlertViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    private let backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView(frame: CGRectZero)
        return backgroundImageView
    }()
    
    var backgroundImage: UIImage {
        get {
            return self.backgroundImageView.image
        }
        set {
            let image = newValue.applyDarkEffect()
            self.backgroundImageView.image = image
        }
    }
    
    init(coder aDecoder: NSCoder!)  {
        super.init(coder: aDecoder)
        self.transitioningDelegate = self
    }
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)  {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.transitioningDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.backgroundImageView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.backgroundImageView.frame = self.view.bounds
    }
    
    // MARK: - Transition
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        return GKAlertViewShowTransition()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        return GKAlertViewShowTransition()
    }
}

