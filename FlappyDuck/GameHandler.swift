//
//  GameHandler.swift
//  FlappyDuck
//
//  Created by Robert Ogiba on 19.10.2017.
//  Copyright © 2017 Robert Ogiba. All rights reserved.
//

import UIKit

class GameHandler {
    var score: Int
    var highScore: Int
    
    static var shared: GameHandler = {
        return GameHandler()
    }()
    
    init() {
        self.score = 0
        self.highScore = 0
        
        loadHighscore()
    }
    
    fileprivate func loadHighscore() {
        highScore = UserDefaults.standard.integer(forKey: "highScore")
    }
    
    func saveGameStats() {
        highScore = max(score, highScore)
        
        UserDefaults.standard.set(highScore, forKey: "highScore")
        UserDefaults.standard.synchronize()
    }
}
