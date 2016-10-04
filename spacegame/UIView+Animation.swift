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
    func toggleView(_ animated: Bool, show: Bool, delay: TimeInterval = 0.0, completion: (() -> Void)?) {
        if animated {
            UIView.animate(withDuration: 0.8, delay: delay, options: .transitionCrossDissolve, animations: { 
                if show {
                    self.alpha = 1.0
                } else {
                    self.alpha = 0.0
                }
                }, completion: { (finished) in
                    completion?()
            })
        } else {
            UIView.animate(withDuration: 0.0, delay: delay, options: .transitionCrossDissolve, animations: { () -> Void in
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
