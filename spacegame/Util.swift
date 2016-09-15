//
//  Util.swift
//  spacegame
//
//  Created by Tomer Ciucran on 3/25/16.
//  Copyright © 2016 Tomer Ciucran. All rights reserved.
//

import Foundation
import UIKit

class Util: NSObject {
    static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    static func random(_ range: Range<UInt32>) -> UInt32 {
        return range.lowerBound + arc4random_uniform(range.upperBound - range.lowerBound + 1)
    }
}
