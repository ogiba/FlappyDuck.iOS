//
//  Int+Extension.swift
//  FlappyDuck
//
//  Created by Robert Ogiba on 19.10.2017.
//  Copyright © 2017 Robert Ogiba. All rights reserved.
//

import Foundation

extension Int {
    func random(from min: Int) -> Int {
        return Int(arc4random_uniform(UInt32(self)) + UInt32(min))
    }
}
