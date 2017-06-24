//
//  Bird.swift
//  FlappyBird
//
//  Created by Marcus Hayward on 02/02/2015.
//  Copyright (c) 2015 Marcus Hayward. All rights reserved.
//

import SpriteKit
import Foundation

class Bird: SKSpriteNode {
    var defaultPositionX: CGFloat = 0.0
    var defaultPositionY: CGFloat = 0.0
    
    init()
    {
        let birdTexture = SKTexture(imageNamed: "bird")
        birdTexture.filteringMode = SKTextureFilteringMode.nearest
        
        super.init(texture: birdTexture, color: UIColor.clear, size: birdTexture.size())
        self.physicsBody = SKPhysicsBody(circleOfRadius:self.size.height / 2.0)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetPosition()
    {
        self.position = CGPoint(x: defaultPositionX, y: defaultPositionY)
    }
    
    func setDefaultPosition(_ defaultPositionX: CGFloat, defaultPositionY: CGFloat)
    {
        self.defaultPositionX = defaultPositionX
        self.defaultPositionY = defaultPositionY
    }
    
    func jump()
    {
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 70))
    }
}
