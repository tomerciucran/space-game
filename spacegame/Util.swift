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
    
    static func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    static func random(range: Range<UInt32>) -> UInt32 {
        return range.startIndex + arc4random_uniform(range.endIndex - range.startIndex + 1)
    }
}
