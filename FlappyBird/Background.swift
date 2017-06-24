import SpriteKit
import Foundation

class Background: SKSpriteNode
{
    var backgroundTexture = SKTexture();
    
    init()
    {
        backgroundTexture = SKTexture(imageNamed: "plainBackground");
        
        super.init(texture: backgroundTexture, color: UIColor.clear, size: backgroundTexture.size())
        self.size.height *= 2;
        self.zPosition = -2;
    }
    
    func setXPosition(_ newX: CGFloat)
    {
        self.position = CGPoint(x: newX, y: backgroundTexture.size().height / 2.0);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
