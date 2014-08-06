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
    }
    
    //MARK: Action
    @IBAction func _didTapSubmitButton(sender: UIButton) {
        if let submitClosure = self.submitClosure? {
            submitClosure(controller: self, enteredValue: self.textField.text)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: TextField Delegate
    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
        
        
        var validationString = textField.text as NSString
        validationString = validationString.stringByReplacingCharactersInRange(range, withString: string)
        
        self.submitButton.enabled = validationString.length > 0
        
        return true
    }
}