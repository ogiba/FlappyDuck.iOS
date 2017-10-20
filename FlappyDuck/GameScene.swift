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
    
    fileprivate var backgroud: SKNode?
    fileprivate var midground: SKNode?
    fileprivate var foreground: SKNode?
    fileprivate var hud: SKNode?
    fileprivate var player: SKNode?
    fileprivate var scoreLabel : SKLabelNode?
    fileprivate var highScoreLabel: SKLabelNode?
    fileprivate var playButton: SKLabelNode?
    
    fileprivate var preparingLabel: SKLabelNode?
    fileprivate var counterLabel: SKLabelNode?
    
    fileprivate var gameOver = false
    fileprivate var gameStarted = false
    fileprivate var score: Int = 0
    
    fileprivate var pipesGenerated = false
    fileprivate var timerIsRunning = false
    fileprivate var timeRemaining = 3
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        scaleFactor = self.size.height / 320
        
        backgroundColor = SKColor.blue
        
        setupEnviroment()
        
        hud = SKNode()
        addChild(hud!)
        
        highScoreLabel = setupHighscoreLabel()
        hud?.addChild(highScoreLabel!)
        update(highscoreLabel: highScoreLabel, withScore: GameHandler.shared.highScore)
        
        playButton = setupStartButton()
        hud?.addChild(playButton!)
        
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
        } else if let _collisioned = (otherNode as? PipeCheckpointNode)?.collision(withPlayer: _player), _collisioned {
            self.score += 1
            GameHandler.shared.score = score
            
            update(scoreLabel: scoreLabel, withScore: score)
            
            if score > GameHandler.shared.highScore {
                update(highscoreLabel: highScoreLabel, withScore: score)
            }
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
            resetState()
            return
        }
        
        if !gameStarted && !timerIsRunning{
            startGame()
        }
        
        player?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 5))
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard !gameOver && gameStarted else {
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
    
    func setupPlayer() {
        player = createPlayer()
        
        if let _player = player {
            foreground?.addChild(_player)
        }
    }
    
    func setupEnviroment() {
        midground = createMidground()
        
        if let _midground = midground {
            addChild(_midground)
        }
        
        foreground = SKNode()
        
        if let _foreground = foreground {
            addChild(_foreground)
        }
    }
    
    //TODO: Check if this function is working properly
    func generatePipes() {
        if !pipesGenerated {
            pipesGenerated = true
            
            let pipePair = createObstacle(atPosition: CGPoint(x: self.size.width, y: 0))
            self.foreground?.addChild(pipePair)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                self.pipesGenerated = false
            })
        }
    }
    
    func moveBackground() {
        let backgroundVelocity : CGFloat = 10.0
        midground?.enumerateChildNodes(withName: "cloud", using: { (node, stop) -> Void in
            if let cloudNode = node as? SKSpriteNode {
                cloudNode.position = CGPoint(x: cloudNode.position.x  - backgroundVelocity,
                                             y: cloudNode.position.y)
                
                if cloudNode.position.x <= 0 {
                    cloudNode.removeFromParent()
                }
            }
        })
    }
    
    func movePipes() {
        let pipesVelocity : CGFloat = 10.0
        foreground?.enumerateChildNodes(withName: "pipePairNode", using: { (node, stop) -> Void in
            let pipePiarNode = node
            pipePiarNode.position = CGPoint(x: pipePiarNode.position.x  - pipesVelocity,
                                            y: pipePiarNode.position.y)
            pipePiarNode.enumerateChildNodes(withName: "pipeNode", using: { (_node, _stop) in
                if let _pipeNode = _node as? PipeNode {
                    if pipePiarNode.position.x <= 0 {
                        _pipeNode.removeFromParent()
                    }
                }
            })
            
            if pipePiarNode.position.x <= 0 {
                pipePiarNode.removeFromParent()
            }
        })
    }
}

//MARK: Game behaviors
extension GameScene {
    func startGame() {
        playButton?.removeFromParent()
        scoreLabel = setupScoreLabel()
        hud?.addChild(scoreLabel!)
        
        setupPlayer()
        
        preparePlayerToPlay()
        
        runTimer()
    }
    
    func endGame() {
        gameOver = true
        gameStarted = false
        player?.physicsBody?.isDynamic = false
        
        GameHandler.shared.saveGameStats()
        
        update(startButton: playButton, withText: "Tap to ducking again")
        hud?.addChild(playButton!)
    }
    
    func resetState() {
        midground?.removeFromParent()
        foreground?.removeFromParent()
        playButton?.removeFromParent()
        
        update(highscoreLabel: scoreLabel, withScore: 0)
        
        timeRemaining = 3
        gameOver = false
        
        setupEnviroment()
        setupPlayer()
        
        preparePlayerToPlay()
        
        runTimer()
    }
    
    func preparePlayerToPlay() {
        preparingLabel = setupPreparingLabel()
        hud?.addChild(preparingLabel!)
        
        counterLabel = setupCounerLabel()
        hud?.addChild(counterLabel!)
        
        update(counterLabel: counterLabel, with: 3)
    }
    
    func runTimer() {
        let _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerRunning(_:)), userInfo: nil, repeats: true)
        
        timerIsRunning = true
    }
    
    @objc func timerRunning(_ timer: Timer) {
        timeRemaining -= 1
        
        update(counterLabel: counterLabel, with: timeRemaining)
        
        print("Remaining time: \(timeRemaining)")
        
        if timeRemaining == 0 {
            timer.invalidate()
            
            self.preparingLabel?.removeFromParent()
            self.counterLabel?.removeFromParent()
            
            timerIsRunning = false
            gameStarted = true
            player?.physicsBody?.isDynamic = true
        }
    }
}
