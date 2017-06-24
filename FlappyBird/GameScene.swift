//
//  GameScene.swift
//  FlappyBird
//
//  Created by Marcus Hayward on 29/01/2015.
//  Copyright (c) 2015 Marcus Hayward. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var bird = Bird()
    var ground = Ground()
    var background = Background()
    
    var score = 0;
    
    let scoreCategory: UInt32 = 0x1 << 0;
    let collisionCategory: UInt32 = 0x1 << 1;
    
    var displayScore: ((Int) -> ())?
    var gameOver: ((Bool) -> ())?;

    override func didMove(to view: SKView) {
        /* Setup your scene here */
        //Physics
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -5.0);
        self.physicsWorld.contactDelegate = self
        
        bird.setDefaultPosition(self.frame.size.width * 0.4, defaultPositionY: self.frame.size.height * 0.6)
        bird.resetPosition()
        self.addChild(bird)
        
        ground.setXPosition(self.size.width / 2.0)
        self.addChild(ground)
        
        background.setXPosition(self.size.width / 2.0)
        self.addChild(background)
        
        var pipes = Pipes(gameScene: self)
        pipes.setFrameWidth(self.frame.size.width)
        pipes.run();
    }

    func getScore() -> Int {
        return self.score;
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if (contact.bodyA.collisionBitMask == collisionCategory) {
            self.gameOver!(true);
            self.isPaused = true;
        } else if (contact.bodyA.collisionBitMask == scoreCategory) {
            contact.bodyA.node?.removeFromParent();
            self.increaseScore();
        }
        self.displayScore!(score);
    }
    
    fileprivate func increaseScore()
    {
        self.score += 1;
    }

    override func touchesBegan(_ touches: Set<NSObject>, with event: UIEvent)
    {
        for touch: AnyObject in touches {
            let location = touch.location(in: self);
            
            bird.jump();
            if (self.isPaused == true) {
                self.resetGame();
            }
        }
    }
    
    fileprivate func resetGame()
    {
        self.isPaused = false;
        self.gameOver!(false);
        score = 0;
        self.displayScore!(score);
    }
   
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
}
