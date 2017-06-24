import SpriteKit
import Foundation

class Ground: SKSpriteNode
{
    var groundTexture = SKTexture();

    init()
    {
        groundTexture = SKTexture(imageNamed: "ground");
        
        super.init(texture: groundTexture, color: UIColor.clear, size: groundTexture.size())
        self.size.width *= 1.5;
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size);
        self.physicsBody?.isDynamic = false;
        self.zPosition = 0;
    }
    
    func setXPosition(_ newX: CGFloat)
    {
        self.position = CGPoint(x: newX, y: groundTexture.size().height / 2.0);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
