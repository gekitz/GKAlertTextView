//
//  GKTextAlertViewController.swift
//  GKAlertView
//
//  Created by Georg Kitz on 25/07/14.
//  Copyright (c) 2014 Aplic GmbH. All rights reserved.
//

import UIKit

class GKTextAlertViewController: GKAlertViewController, UITextFieldDelegate {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var submitButton: UIButton!
    
    var submitClosure: ((controller:UIViewController, enteredValue: String) -> ())?
    
    var titleString:String?
    var messageString:String?
    var submitButtonText:String?
    var placeholderText:String?
    
    init() {
        super.init(nibName: "GKTextAlertViewController", bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)  {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textField.becomeFirstResponder();
        
        self._updateInterface()
    }
    
    //MARK: Action
    @IBAction func _didTapSubmitButton(sender: UIButton) {
        if let submitClosure = self.submitClosure? {
            submitClosure(controller: self, enteredValue: self.textField.text)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Mark: Private
    private func _updateInterface() {
        if let titleString = self.titleString? {
            self.titleLabel.text = titleString
        }
        
        if let messageString = self.messageString? {
            self.textLabel.text = messageString
        }
        
        if let placeholderText = self.placeholderText? {
            self.textField.placeholder = placeholderText
        }
        
        if let submitButtonText = self.submitButtonText? {
            self.submitButton.setTitle(submitButtonText, forState: UIControlState.Normal)
        }
    }
    
    //MARK: TextField Delegate
    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
        
        
        var validationString = textField.text as NSString
        validationString = validationString.stringByReplacingCharactersInRange(range, withString: string)
        
        self.submitButton.enabled = validationString.length > 0
        
        return true
    }
}