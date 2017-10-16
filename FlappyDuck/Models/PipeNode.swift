//
//  PipeNode.swift
//  FlappyDuck
//
//  Created by Robert Ogiba on 16.10.2017.
//  Copyright © 2017 Robert Ogiba. All rights reserved.
//

import SpriteKit

class PipeNode: GenericNode {
    override func collision(withPlayer player: SKNode) -> Bool {
        guard let _physicsBody = player.physicsBody else {
            return false
        }
        
        if _physicsBody.velocity.dx < 0 {
            _physicsBody.velocity = CGVector(dx: 250, dy: _physicsBody.velocity.dy)
        }
        
        return false
    }
}
