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
            
            let cloudNode = SKSpriteNode(imageNamed: name)
            cloudNode.name = "cloud"
            
            if let _anchor = anchor, let _yPos = yPos {
                cloudNode.anchorPoint = _anchor
                cloudNode.position = CGPoint(x: 500 * CGFloat(index), y: _yPos)
            }
            
            midgroundNode.addChild(cloudNode)
        }
        
        return midgroundNode
    }
    
    func createPlayer() -> SKNode {
        let playerNode = SKNode()
        playerNode.position = CGPoint(x: 100, y: self.size.height / 2.0)
        
        let sprite = SKSpriteNode(imageNamed: "player")
        sprite.size = CGSize(width: sprite.size.width / 8, height: sprite.size.height / 8)
        playerNode.addChild(sprite)
        
        playerNode.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 2.0)
        playerNode.physicsBody?.isDynamic = false
        playerNode.physicsBody?.allowsRotation = false
        
        playerNode.physicsBody?.restitution = 1
        playerNode.physicsBody?.friction = 0
        playerNode.physicsBody?.angularDamping = 0
        playerNode.physicsBody?.linearDamping = 0
        
        playerNode.physicsBody?.usesPreciseCollisionDetection = true
        
        playerNode.physicsBody?.categoryBitMask = CollisionBitMask.player
        
        playerNode.physicsBody?.collisionBitMask = 0
        playerNode.physicsBody?.contactTestBitMask = CollisionBitMask.pipe
    
        return playerNode
    }
    
    func createPipe(atPosition position: CGPoint, with size: CGSize) -> PipeNode {
        let pipeNode = PipeNode()
        
        let position = CGPoint(x: position.x, y: position.y)
        pipeNode.position = position
        pipeNode.name = "pipeNode"
        
        let sprite = SKSpriteNode(imageNamed: "pipe")
        sprite.size = size
        pipeNode.addChild(sprite)
        
        pipeNode.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        pipeNode.physicsBody?.isDynamic = false
        pipeNode.physicsBody?.categoryBitMask = CollisionBitMask.pipe
        pipeNode.physicsBody?.collisionBitMask = 0
        
        return pipeNode
    }
    
    func createFreePipeSpace(atPosition position: CGPoint, with size: CGSize) -> GenericNode {
        let freeNode = GenericNode()
        freeNode.position = position
        freeNode.name = "pipeFreeSpace"
        
        let sprite = SKSpriteNode(color: UIColor(white: 0.0 , alpha: 1.0), size: size)
        freeNode.addChild(sprite)
        
        freeNode.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        freeNode.physicsBody?.isDynamic = false
        freeNode.physicsBody?.categoryBitMask = CollisionBitMask.pipeFreeSpae
        freeNode.physicsBody?.collisionBitMask = 0
        
        return freeNode
    }
    
    func createPipePair(atPosition position: CGPoint) -> SKNode {
        let pairNode = SKNode()
        pairNode.name = "pipePairNode"
        pairNode.position = position
        
        let pipeFreeSpaceHeight: CGFloat = 100
        let randomValue = Int(self.size.height).random(from: Int(pipeFreeSpaceHeight))
        print("Random value: \(randomValue)")
        
        let pipeWidth: CGFloat = 50
        
        let floatedRandom = CGFloat(randomValue)
        let bottomPipeYPos = floatedRandom / 2.0
        let pipeFreeSpaceYPos = floatedRandom + (pipeFreeSpaceHeight / 2.0)
        let topNodeHeight = self.size.height - (floatedRandom + pipeFreeSpaceHeight)
        print("Top node height: \(topNodeHeight)")
        let topPipeYPos = (floatedRandom + pipeFreeSpaceHeight) + topNodeHeight / 2.0
        
        let bottomPipeNode = createPipe(atPosition: CGPoint(x: 0, y: bottomPipeYPos),
                                        with: CGSize(width: pipeWidth, height: floatedRandom))
        
        let topPipeNode = createPipe(atPosition: CGPoint(x: 0, y: topPipeYPos),
                                  with: CGSize(width: pipeWidth, height: topNodeHeight))
        
        let pipeSpaceNode = createFreePipeSpace(atPosition: CGPoint(x: 0, y: pipeFreeSpaceYPos),
                                                with: CGSize(width: pipeWidth, height: pipeFreeSpaceHeight))
        
        pairNode.addChild(bottomPipeNode)
        pairNode.addChild(pipeSpaceNode)
        pairNode.addChild(topPipeNode)
        
        return pairNode
    }
}
