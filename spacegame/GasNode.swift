//
//  GasNode.swift
//  spacegame
//
//  Created by Tomer Ciucran on 3/25/16.
//  Copyright © 2016 Tomer Ciucran. All rights reserved.
//

import SpriteKit

class GasNode: SKSpriteNode {

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init(position: CGPoint, color: UIColor, size: CGSize) {
        self.init(texture: SKTexture(imageNamed: "gas1"), color: color, size: size)
        self.position = position
        self.zPosition = -1
        setScale(0.7)
    }
    
    func animate() {
        run(SKAction.repeatForever(SKAction.animate(with: [SKTexture(imageNamed: "gas1"), SKTexture(imageNamed: "gas2"), SKTexture(imageNamed: "gas3")], timePerFrame: 0.1, resize: true, restore: true)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
