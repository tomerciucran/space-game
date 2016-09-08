//
//  StarfieldNode.swift
//  spacegame
//
//  Created by Tomer Ciucran on 9/8/16.
//  Copyright © 2016 Tomer Ciucran. All rights reserved.
//

import SpriteKit

class StarfieldNode: SKEmitterNode {
    static func initialize(frame: CGRect, color: SKColor, starSpeedY: CGFloat, starsPerSecond: CGFloat, starScaleFactor: CGFloat) -> SKEmitterNode {
        // Determine the time a star is visible on screen
        let lifetime =  frame.size.height * UIScreen.mainScreen().scale / starSpeedY
        
        // Create the emitter node
        let emitterNode = SKEmitterNode()
        emitterNode.particleTexture = SKTexture(imageNamed: "star")
        emitterNode.particleBirthRate = starsPerSecond
        emitterNode.particleColor = SKColor.lightGrayColor()
        emitterNode.particleSpeed = starSpeedY * -1
        emitterNode.particleScale = starScaleFactor
        emitterNode.particleColorBlendFactor = 1
        emitterNode.particleLifetime = lifetime
        
        // Position in the middle at top of the screen
        emitterNode.position = CGPoint(x: frame.size.width/2, y: frame.size.height)
        emitterNode.particlePositionRange = CGVector(dx: frame.size.width, dy: 0)
        
        // Fast forward the effect to start with a filled screen
        emitterNode.advanceSimulationTime(NSTimeInterval(lifetime))
        
        return emitterNode
    }
    
    
}
