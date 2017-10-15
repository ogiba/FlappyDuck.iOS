//
//  GameElements.swift
//  FlappyDuck
//
//  Created by Robert Ogiba on 15.10.2017.
//  Copyright © 2017 Robert Ogiba. All rights reserved.
//

import SpriteKit

extension GameScene {
    func createMidground() -> SKNode {
        let midgroundNode = SKNode()
        var anchor: CGPoint?
        var yPos: CGFloat?
        
        for index in 0...9 {
            let randomNumber = arc4random() % 2
            let name: String
            
            if randomNumber > 0 {
                name = "topCloud"
                anchor = CGPoint(x: 0.5, y: 0)
                yPos = 100
            } else {
                name = "bottomCloud"
                anchor = CGPoint(x: 0.5, y: 1)
                yPos = self.size.height
            }
            
            let cloduNode = SKSpriteNode(imageNamed: name)
            
            if let _anchor = anchor, let _yPos = yPos {
                cloduNode.anchorPoint = _anchor
                cloduNode.position = CGPoint(x: 500 * CGFloat(index), y: _yPos)
            }
            
            midgroundNode.addChild(cloduNode)
        }
        
        return midgroundNode
    }
}
