//
//  SpaceShipNode.swift
//  spacegame
//
//  Created by Tomer Ciucran on 3/25/16.
//  Copyright © 2016 Tomer Ciucran. All rights reserved.
//

import SpriteKit

class SpaceShipNode: SKSpriteNode {
    
    var currentLane = Lanes.Middle
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init(position: CGPoint, color: UIColor, size: CGSize) {
        self.init(texture: SKTexture(imageNamed: "rocket"), color: color, size: size)
        self.position = position
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = true
        physicsBody?.categoryBitMask = PhysicsCategory.Spaceship
        physicsBody?.contactTestBitMask = PhysicsCategory.Meteor
        physicsBody?.collisionBitMask = PhysicsCategory.None
        setScale(0.6)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func screenTapAction(_ touchLocation: CGPoint) {
        let offset = touchLocation.x - position.x
        if offset < 0 {
            if currentLane == Lanes.Middle {
                moveShip(Lanes.Middle, toLane: Lanes.Left)
            } else if currentLane == Lanes.Right {
                moveShip(Lanes.Right, toLane: Lanes.Middle)
            } else {
                return
            }
        } else {
            if currentLane == Lanes.Middle {
                moveShip(Lanes.Middle, toLane: Lanes.Right)
            } else if currentLane == Lanes.Left {
                moveShip(Lanes.Left, toLane: Lanes.Middle)
            } else {
                return
            }
        }
    }
    
    func moveShip(_ fromLane: CGFloat, toLane: CGFloat) {
        let actionMove = SKAction.moveTo(x: toLane, duration: 0.4)
        let actionRotate: SKAction
        let actionRotateBack: SKAction
        if fromLane < toLane {
            actionRotate = SKAction.rotate(byAngle: CGFloat(-M_PI_4/2), duration: 0.3)
            actionRotateBack = SKAction.rotate(byAngle: CGFloat(M_PI_4/2), duration: 0.3)
        } else {
            actionRotate = SKAction.rotate(byAngle: CGFloat(M_PI_4/2), duration: 0.3)
            actionRotateBack = SKAction.rotate(byAngle: CGFloat(-M_PI_4/2), duration: 0.3)
        }
        
        run(actionMove)
        run(SKAction.sequence([actionRotate, actionRotateBack]))
        currentLane = toLane
    }
}
