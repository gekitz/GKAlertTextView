//
//  GKAlertView.swift
//  GKAlertView
//
//  Created by Georg Kitz on 25/07/14.
//  Copyright (c) 2014 Aplic GmbH. All rights reserved.
//

import UIKit

class GKNormalAlertView: UIView {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var submitButton: UIButton!
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func intrinsicContentSize() -> CGSize {
        let titleSize = titleLabel.intrinsicContentSize()
        let textSize = textLabel.intrinsicContentSize()
        
        submitButton.sizeToFit()
        let btnSize = submitButton.frame.size
        
        println("\(btnSize)")
        
        let dist: CGFloat = 10.0
        let height = dist + titleSize.height + dist + textSize.height + dist + btnSize.height
        return CGSize(width: 280, height: height)
    }
}
