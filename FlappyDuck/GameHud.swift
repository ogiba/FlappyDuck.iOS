//
//  GameHud.swift
//  FlappyDuck
//
//  Created by Robert Ogiba on 19.10.2017.
//  Copyright © 2017 Robert Ogiba. All rights reserved.
//

import SpriteKit

extension GameScene {
    var scoreText: String {
        get{
            return "Walls beaten %@"
        }
    }
    
    var highscoreText: String {
        get {
            return "Highscore: %@"
        }
    }
    
    func setupScoreLabel() -> SKLabelNode {
        let scoreLabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
        scoreLabel.fontSize = 20
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: self.size.width - 20, y: self.size.height - 40)
        scoreLabel.horizontalAlignmentMode = .right
        
        scoreLabel.text = String(format: scoreText, "0")
        
        return scoreLabel
    }
    
    func update(scoreLabel: SKLabelNode?, withScore score: Int) {
        scoreLabel?.text = String(format: scoreText, "\(score)")
    }
    
    func setupHighscoreLabel() -> SKLabelNode {
        let scoreLabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
        scoreLabel.fontSize = 20
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: 20, y: self.size.height - 40)
        scoreLabel.horizontalAlignmentMode = .left
        
        scoreLabel.text = String(format: highscoreText, "0")
        
        return scoreLabel
    }
    
    func update(highscoreLabel: SKLabelNode?, withScore score: Int) {
        highscoreLabel?.text = String(format: highscoreText, "\(score)")
    }
    
    func setupStartButton() -> SKLabelNode {
        let buttonNode = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
        buttonNode.fontSize = 30
        buttonNode.fontColor = SKColor.white
        buttonNode.position = CGPoint(x: self.size.width / 2.0, y: self.size.height / 2.0)
        buttonNode.horizontalAlignmentMode = .center
        
        buttonNode.text = "Start ducking"
        
        return buttonNode
    }
    
    func update(startButton: SKLabelNode?, withText text: String) {
        startButton?.text = text
    }
    
    func setupPreparingLabel() -> SKLabelNode {
        let preparingInfoNode = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
        preparingInfoNode.fontSize = 30
        preparingInfoNode.fontColor = SKColor.white
        preparingInfoNode.position = CGPoint(x: self.size.width / 2.0, y: self.size.height / 2.0)
        preparingInfoNode.horizontalAlignmentMode = .center
        
        preparingInfoNode.text = "Game will start in"
        
        return preparingInfoNode
    }
    
    func setupCounerLabel() -> SKLabelNode {
        let counterNode = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
        counterNode.fontSize = 30
        counterNode.fontColor = SKColor.white
        counterNode.position = CGPoint(x: self.size.width / 2.0, y: self.size.height / 2.0 - 50)
        counterNode.horizontalAlignmentMode = .center
        
        counterNode.text = ""
        
        return counterNode
    }
    
    func update(counterLabel: SKLabelNode?, with value: Int) {
        counterLabel?.text = "\(value)"
    }
}
