//
//  GameScene.swift
//  FlappyDuck
//
//  Created by Robert Ogiba on 15.10.2017.
//  Copyright © 2017 Robert Ogiba. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    public var scaleFactor: CGFloat?
    fileprivate var label : SKLabelNode?
    fileprivate var backgroud: SKNode?
    fileprivate var midground: SKNode?
    fileprivate var foreground: SKNode?
    fileprivate var player: SKNode?
    fileprivate var gameOver = false
    
    fileprivate var pipesGenerated = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        scaleFactor = self.size.height / 320
        
        backgroundColor = SKColor.blue
        
        midground = createMidground()
        
        if let _midground = midground {
            addChild(_midground)
        }
        
        foreground = SKNode()
        
        if let _foreground = foreground {
            addChild(_foreground)
        }
        
        player = createPlayer()
        
        if let _player = player {
            foreground?.addChild(_player)
        }
        
//        let pipeNode = createPipe(atPosition: CGPoint(x: self.size.width, y: self.size.height - 125))
//        let pipeNode2 = createPipe(atPosition: CGPoint(x: self.size.width, y: 40))
//
//        foreground?.addChild(pipeNode)
//        foreground?.addChild(pipeNode2)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        physicsWorld.contactDelegate = self
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let _player = player else {
            return
        }
        
        var otherNode: SKNode?
        
        if contact.bodyA.node != _player {
            otherNode = contact.bodyA.node
        } else {
            otherNode = contact.bodyB.node
        }
        
        if let _collisioned = (otherNode as? PipeNode)?.collision(withPlayer: _player), _collisioned {
            endGame()
        }
    }
    
    override func didSimulatePhysics() {
        guard let _player = player else {
            return
        }
    }
    
    override func didMove(to view: SKView) {
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameOver {
            return
        }
        
        player?.physicsBody?.isDynamic = true
        player?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 5))
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if gameOver {
            return
        }
        
        generatePipes()
        moveBackground()
        movePipes()
        
        if let _player = player {
            if _player.position.y > self.size.height {
                endGame()
            } else if _player.position.y < 0 {
                endGame()
            }
        }
    }
    
    func generatePipes() {
        if !pipesGenerated {
            pipesGenerated = true
            let pipeNode = createPipe(atPosition: CGPoint(x: self.size.width, y: self.size.height - 125))
            let pipeNode2 = createPipe(atPosition: CGPoint(x: self.size.width, y: 40))
            
            foreground?.addChild(pipeNode)
            foreground?.addChild(pipeNode2)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                self.pipesGenerated = false
            })
        }
    }
    
    func moveBackground() {
        let backgroundVelocity : CGFloat = 10.0
        midground?.enumerateChildNodes(withName: "cloud", using: { (node, stop) -> Void in
            if let cloudNode = node as? SKSpriteNode {
                cloudNode.position = CGPoint(x: cloudNode.position.x  - backgroundVelocity, y: cloudNode.position.y)
                
                if cloudNode.position.x <= 0 {
                    cloudNode.removeFromParent()
                }
            }
        })
    }
    
    func movePipes() {
        let pipesVelocity : CGFloat = 10.0
        foreground?.enumerateChildNodes(withName: "pipeNode", using: { (node, stop) -> Void in
            if let pipeNode = node as? PipeNode {
                pipeNode.position = CGPoint(x: pipeNode.position.x  - pipesVelocity, y: pipeNode.position.y)
                
                if pipeNode.position.x <= 0 {
                    pipeNode.shouldRemoveNode(playerX: self.player!.position.y)
                }
            }
        })
    }
    
    func endGame() {
        gameOver = true
        player?.physicsBody?.isDynamic = false
    }
}
