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
}
