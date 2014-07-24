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

        self._showAlert(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Private
    
    @IBAction func _showAlert(sender: UIButton?) {
        let alert = GKAlertView(frame: CGRectMake(0, 0, 320, 568))
        alert.completion = {(value: String) in
            println("Got a value from the block \(value)")
            alert.show(false)
        };
        alert.show(true)
    }
}

