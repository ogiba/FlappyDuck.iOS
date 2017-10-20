//
//  ObstacleNode.swift
//  FlappyDuck
//
//  Created by Robert Ogiba on 21.10.2017.
//  Copyright © 2017 Robert Ogiba. All rights reserved.
//

import SpriteKit

class ObstacleNode: GenericNode {
    var size: CGSize = CGSize.zero
    
    func generateItems() {
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
        
        let pipeSpaceNode = createPipeFreeSpace(atPosition: CGPoint(x: pipeWidth / 2.0, y: pipeFreeSpaceYPos),
                                                with: CGSize(width: 10, height: pipeFreeSpaceHeight))
        
        self.addChild(bottomPipeNode)
        self.addChild(pipeSpaceNode)
        self.addChild(topPipeNode)
    }
    
    func refreshItem() {
        self.removeAllChildren()
        
        generateItems()
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
    
    func createPipeFreeSpace(atPosition position: CGPoint, with size: CGSize) -> PipeCheckpointNode {
        let freeNode = PipeCheckpointNode()
        freeNode.position = position
        freeNode.name = "pipeFreeSpace"
        
        let sprite = SKSpriteNode(color: UIColor.clear, size: size)
        freeNode.addChild(sprite)
        
        freeNode.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        freeNode.physicsBody?.isDynamic = false
        freeNode.physicsBody?.categoryBitMask = CollisionBitMask.pipeFreeSpae
        freeNode.physicsBody?.collisionBitMask = 0
        
        return freeNode
    }
}
