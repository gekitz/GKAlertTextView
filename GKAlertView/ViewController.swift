//
//  ViewController.swift
//  GKAlertView
//
//  Created by Georg Kitz on 22/07/14.
//  Copyright (c) 2014 Aplic GmbH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()

//        self._showAlert(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Private
    
    @IBAction func _showAlertController(sender: UIButton) {
        let ctr = GKTextAlertViewController()
        ctr.submitClosure = {(ctr: UIViewController, enteredValue: String) in
            println("\(enteredValue)")
        }
        self.presentViewController(ctr, animated: true, completion: nil)
    }
    
    @IBAction func _showNormalAlertController(sender: UIButton) {
        let ctr = GKNormalAlertViewController()
        ctr.success = {(ctr: GKNormalAlertViewController, success: Bool) in
            println("\(success)")
        }
        self.presentViewController(ctr, animated: true, completion: nil)
    }
}

