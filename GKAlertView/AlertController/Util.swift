//
//  Util.swift
//  GKAlertView
//
//  Created by Georg Kitz on 06/08/14.
//  Copyright (c) 2014 Aplic GmbH. All rights reserved.
//

import Foundation
import UIKit

func degreesToRadian(degree: Double) -> CGFloat {
    let radians:Double =  (degree) / 180.0 * M_PI
    return CGFloat(radians)
}