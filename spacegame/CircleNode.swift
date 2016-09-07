//
//  CircleNode.swift
//  spacegame
//
//  Created by Tomer Ciucran on 9/7/16.
//  Copyright © 2016 Tomer Ciucran. All rights reserved.
//

import SpriteKit

class CircleNode: SKShapeNode {
    
    var radius: CGFloat {
        didSet {
            self.path = CircleNode.path(self.radius)
        }
    }
    
    init(radius: CGFloat, position: CGPoint) {
        self.radius = radius
        super.init()
        self.path = CircleNode.path(self.radius)
        self.position = position
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func path(radius: CGFloat) -> CGMutablePathRef {
        let path: CGMutablePathRef = CGPathCreateMutable()
        CGPathAddArc(path, nil, 0.0, 0.0, radius, 0.0, CGFloat(2.0 * M_PI), true)
        return path
    }
    
    func ripple(scale: CGFloat, duration: NSTimeInterval, completionHandler: (node: CircleNode) -> Void) {
        if let scene = self.scene {
            let currentRadius = radius
            let finalRadius = radius * scale
            
            let circleNode = CircleNode(radius: radius, position: position)
            circleNode.strokeColor = strokeColor
            circleNode.fillColor = fillColor
            circleNode.position = position
            circleNode.zRotation = zRotation
            circleNode.lineWidth = lineWidth
            circleNode.zPosition = 2
            circleNode.userInteractionEnabled = false
            
            if let index = scene.children.indexOf(self) {
                scene.insertChild(circleNode, atIndex: index)
                
                let scaleAction = SKAction.customActionWithDuration(duration, actionBlock: { node, elapsedTime in
                    let circleNode = node as! CircleNode
                    let fraction = elapsedTime / CGFloat(duration)
                    circleNode.radius = currentRadius + (fraction * finalRadius)
                })
                
                let fadeAction = SKAction.fadeAlphaTo(0.8, duration: duration)
                fadeAction.timingMode = SKActionTimingMode.EaseOut
                
                let actionGroup = SKAction.group([scaleAction])
                
                circleNode.runAction(actionGroup, completion: {
                    completionHandler(node: circleNode)
//                    circleNode.removeFromParent();
                })
            }
        }
    }
}
