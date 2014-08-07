//
//  GKNormalAlertViewController.swift
//  GKAlertView
//
//  Created by Georg Kitz on 25/07/14.
//  Copyright (c) 2014 Aplic GmbH. All rights reserved.
//

import UIKit

class GKNormalAlertViewController: GKAlertViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var centerSeparator: UIView!
    @IBOutlet var centerSeparatorAlignment: NSLayoutConstraint!
    
    var success: ((controller:GKNormalAlertViewController, success:Bool)->())?
    
    var titleString: String?
    var messageString: String?
    var cancelButtonText: String?
    var submitButtonText: String?
    
    init () {
        super.init(nibName: "GKNormalAlertViewController", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self._updateInterface()
        
        if let cancelButtonText = self.cancelButtonText? {
            
        } else {
            self.cancelButton.hidden = true
            self.centerSeparator.hidden = true
            self.centerSeparatorAlignment.constant = (CGRectGetWidth(self.view.frame) / 2) + 2
        }
    }
    
    //MARK: Action Methods
    @IBAction func _cancelAction(sender: UIButton) {
        self._dismissWithSuccess(false)
    }
    
    @IBAction func _submitAction(sender: UIButton) {
        self._dismissWithSuccess(true)
    }
    
    //MARK: Private
    func _dismissWithSuccess(success: Bool) {
        
        if let successClosure = self.success? {
            successClosure(controller: self, success: success)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    private func _updateInterface() {
        if let titleString = self.titleString? {
            self.titleLabel.text = titleString
        }
        
        if let messageString = self.messageString? {
            self.textLabel.text = messageString
        }
        
        if let cancelButtonText = self.cancelButtonText? {
            self.cancelButton.setTitle(cancelButtonText, forState: .Normal)
        }
        
        if let submitButtonText = self.submitButtonText? {
            self.submitButton.setTitle(submitButtonText, forState: .Normal)
        }
    }
}
