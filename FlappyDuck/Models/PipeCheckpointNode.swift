//
//  PipeCheckpointNode.swift
//  FlappyDuck
//
//  Created by Robert Ogiba on 19.10.2017.
//  Copyright © 2017 Robert Ogiba. All rights reserved.
//

import SpriteKit

class PipeCheckpointNode: GenericNode {
    override func collision(withPlayer player: SKNode) -> Bool {
        guard let _ = player.physicsBody else {
            return false
        }
        
        return true
    }
}
