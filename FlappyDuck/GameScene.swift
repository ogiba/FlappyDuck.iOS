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
    
    fileprivate var scaleFactor: CGFloat?
    fileprivate var label : SKLabelNode?
    fileprivate var backgroud: SKNode?
    fileprivate var midground: SKNode?
    fileprivate var foreground: SKNode?
    fileprivate var player: SKNode?
    fileprivate var gameOver = false
    
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
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        physicsWorld.contactDelegate = self
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
        player?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 10))
        
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
        
        if let _player = player {
            if _player.position.y > self.size.height {
                endGame()
            } else if _player.position.y < 0 {
                endGame()
            }
        }
    }
    
    func endGame() {
        gameOver = true
        player?.physicsBody?.isDynamic = false
    }
}
