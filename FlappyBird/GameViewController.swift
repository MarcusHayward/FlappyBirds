//
//  GameViewController.swift
//  FlappyBird
//
//  Created by Marcus Hayward on 29/01/2015.
//  Copyright (c) 2015 Marcus Hayward. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(_ file : NSString) -> SKNode? {
        if let path = Bundle.main.path(forResource: file as String, ofType: "sks") {
            var sceneData = Data(bytesNoCopy: path, count: .DataReadingMappedIfSafe, deallocator: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)

            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var gameOverPanel: UIImageView!
    var score = 0;

    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            
            skView.presentScene(scene)
            
            gameOverPanel.isHidden = true
            gameOverPanel.image = UIImage(named: "GameOver")
            scene.displayScore = self.displayScore;
            scene.gameOver = self.showGameOver;

        }
    }
    
    func displayScore(_ score: Int)
    {
        scoreLabel.text = NSString(format: "%ld", score) as String;
    }
    
    func showGameOver(_ isGameOver: Bool) {
        if (isGameOver) {
            gameOverPanel.isHidden = false
        } else {
            gameOverPanel.isHidden = true
        }
    }

    override var shouldAutorotate : Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return Int(UIInterfaceOrientationMask.allButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.all.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
}
