//
//  GKNormalAlertViewController.swift
//  GKAlertView
//
//  Created by Georg Kitz on 25/07/14.
//  Copyright (c) 2014 Aplic GmbH. All rights reserved.
//

import UIKit

class GKNormalAlertViewController: GKAlertViewController {

    var success: ((controller:GKNormalAlertViewController, success:Bool)->())?
    
    init () {
        super.init(nibName: "GKNormalAlertViewController", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
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

}
