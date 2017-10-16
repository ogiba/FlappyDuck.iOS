//
//  GenericNode.swift
//  FlappyDuck
//
//  Created by Robert Ogiba on 15.10.2017.
//  Copyright © 2017 Robert Ogiba. All rights reserved.
//

import SpriteKit

class GenericNode: SKNode {
    func collision(withPlayer player: SKNode) -> Bool {
        return false
    }
    
    func shouldRemoveNode(playerX: CGFloat) {
        if playerX > self.position.x - 50 {
            self.removeFromParent()
        }
    }
}
