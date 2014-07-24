//
//  GKTextAlertContentView.swift
//  GKAlertView
//
//  Created by Georg Kitz on 23/07/14.
//  Copyright (c) 2014 Aplic GmbH. All rights reserved.
//

import UIKit

class GKTextAlertContentView: UIView {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var submitButton: UIButton!
    
    var completion: ((value:String)->())?
    
    init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
    }

    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override func intrinsicContentSize() -> CGSize {
        
        let titleSize = titleLabel.intrinsicContentSize()
        let textSize = textLabel.intrinsicContentSize()
        let textFieldSize = textField.intrinsicContentSize()
        let btnSize = submitButton.intrinsicContentSize()
        
        let dist: CGFloat = 10.0
        let height = dist + titleSize.height + dist + textSize.height + dist + textFieldSize.height + dist + btnSize.height + dist + dist
        return CGSize(width: 280, height: height)
    }
    
    //MARK: Action Methods
    @IBAction func _submitAction(sender: UIButton) {
        if let completion = completion? {
            completion(value: self.textField.text)
        }
    }
}
