//
//  UIView+Animation.swift
//  spacegame
//
//  Created by Tomer Ciucran on 3/25/16.
//  Copyright © 2016 Tomer Ciucran. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func toggleView(animated: Bool, show: Bool, completion: (() -> Void)?) {
        if animated {
            UIView.animateWithDuration(0.8, animations: { () -> Void in
                if show {
                    self.alpha = 1.0
                } else {
                    self.alpha = 0.0
                }
                }, completion: { (bool: Bool) -> Void in
                    completion?()
            })
        } else {
            UIView.animateWithDuration(0.0, animations: { () -> Void in
                if show {
                    self.alpha = 1.0
                } else {
                    self.alpha = 0.0
                }
                }, completion: { (bool: Bool) -> Void in
                    completion?()
            })
        }
    }
}
