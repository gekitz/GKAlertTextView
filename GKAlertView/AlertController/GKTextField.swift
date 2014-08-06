//
//  GKTextField.swift
//  GKAlertView
//
//  Created by Georg Kitz on 23/07/14.
//  Copyright (c) 2014 Aplic GmbH. All rights reserved.
//

import UIKit

@IBDesignable
class GKTextField: UITextField {

    @IBInspectable var backgroundColoring: UIColor?
    @IBInspectable var placeholderBackgroundColor: UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _initialize()
    }
    
    required init(coder aDecoder: NSCoder!)  {
        super.init(coder: aDecoder)
        _initialize()
    }
    
    override func awakeFromNib() {
        _initialize()
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)

        let ctx = UIGraphicsGetCurrentContext()
        let frame = self.bounds
        
        if let backgroundColor = self.backgroundColoring? {
            backgroundColor.set()
        }
        CGContextFillRect(ctx, frame)
    }
    
    
    override func drawPlaceholderInRect(rect: CGRect) {
        let fontHeight = self.font.lineHeight
        let bounds = CGRectInset(rect, 1, (CGRectGetHeight(rect) - fontHeight) / 2)
        
        let attributes = [
            NSFontAttributeName: self.font,
            NSForegroundColorAttributeName: self.placeholderBackgroundColor!
        ]

        let p: NSString = self.placeholder as NSString
        p.drawInRect(bounds, withAttributes: attributes)
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 10)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect  {
        return CGRectInset(bounds, 10, 10)
    }
    
    //Private Methods
    func _initialize() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 4
    }
}
