//
//  Pipes.swift
//  FlappyBird
//
//  Created by Marcus Hayward on 02/02/2015.
//  Copyright (c) 2015 Marcus Hayward. All rights reserved.
//

import Foundation
import SpriteKit

class Pipes {
    var pipeUpTexture = SKTexture()
    var pipeDownTexture = SKTexture()
    var scoreGap = SKSpriteNode()
    var pipesMoveAndRemove = SKAction()
    
    let pipeGap = 200.0
    var pipePair = SKNode()
    var frameWidth: CGFloat = 0.0;
    var spawnThenDelayForeverPipes = SKAction()
    
    var gameScene:GameScene
    let scoreCategory: UInt32 = 0x1 << 0;
    let collisionCategory: UInt32 = 0x1 << 1;
    
    init(gameScene: GameScene)
    {
        pipeUpTexture = SKTexture(imageNamed: "pipeUp");
        pipeDownTexture = SKTexture(imageNamed: "pipeDown");
        self.gameScene = gameScene
    }
    
    func setFrameWidth(_ frameWidth: CGFloat) {
        self.frameWidth = frameWidth
    }
    
    func spawnPipes() {

        pipePair = SKNode();
        pipePair.position = CGPoint(x: frameWidth + pipeUpTexture.size().width, y: 0);
        pipePair.zPosition = -1;
        
        let height = UInt32(frameWidth / 8);
        let y = arc4random() % height + height;
        
        let pipeDown = SKSpriteNode(texture: pipeDownTexture);
        pipeDown.position = CGPoint(x: 0.0, y: CGFloat(y) + pipeDown.size.height + CGFloat(pipeGap));
        pipeDown.physicsBody = SKPhysicsBody(rectangleOf: pipeDown.size);
        pipeDown.physicsBody?.isDynamic = false;
        pipeDown.physicsBody?.categoryBitMask = collisionCategory;
        pipeDown.physicsBody?.collisionBitMask = collisionCategory;
        pipeDown.physicsBody?.contactTestBitMask = collisionCategory;
        
        let pipeUp = SKSpriteNode(texture: pipeUpTexture);
        pipeUp.position = CGPoint(x: 0.0, y: CGFloat(y));
        pipeUp.physicsBody = SKPhysicsBody(rectangleOf: pipeUp.size);
        pipeUp.physicsBody?.isDynamic = false;
        pipeUp.physicsBody?.categoryBitMask = collisionCategory;
        pipeUp.physicsBody?.collisionBitMask = collisionCategory;
        pipeUp.physicsBody?.contactTestBitMask = collisionCategory;
        
        let scoreGap = SKSpriteNode();
        scoreGap.size.height = frameWidth;
        scoreGap.position = CGPoint(x: 0.0, y: CGFloat(y) + CGFloat(pipeGap));
        scoreGap.size.width = 10;
        scoreGap.physicsBody = SKPhysicsBody(rectangleOf: scoreGap.size);
        scoreGap.physicsBody?.isDynamic = false;
        scoreGap.physicsBody?.categoryBitMask = scoreCategory;
        scoreGap.physicsBody?.collisionBitMask = scoreCategory;
        scoreGap.physicsBody?.contactTestBitMask = scoreCategory;
        
        pipePair.addChild(pipeDown);
        pipePair.addChild(pipeUp);
        pipePair.addChild(scoreGap);
        
        pipePair.run(pipesMoveAndRemove);
        gameScene.addChild(pipePair)
    }
    
    func attach(_ scene: GameScene)
    {
        gameScene = scene;
    }
    
    func run()
    {
        let distanceToMove = CGFloat(self.frameWidth + 2.0 * pipeUpTexture.size().width);
        let movePipes = SKAction.moveBy(x: -distanceToMove, y: 0.0, duration: TimeInterval(0.01 * distanceToMove));
        let remove = SKAction.removeFromParent();
        pipesMoveAndRemove = SKAction.sequence([movePipes, remove]);
        
        let spawnPipes = SKAction.run({() in self.spawnPipes()});
        let delay = SKAction.wait(forDuration: TimeInterval(2.0));
        let spawnThenDelayPipes = SKAction.sequence([spawnPipes, delay]);
        spawnThenDelayForeverPipes = SKAction.repeatForever(spawnThenDelayPipes);
        gameScene.run(spawnThenDelayForeverPipes);
    }
}
