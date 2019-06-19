//
//  GameScene.swift
//  Game2
//
//  Created by MacStudent on 2019-06-19.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let mario = SKSpriteNode(imageNamed: "mario")
    
    
    var timeOfLastUpdate:TimeInterval = 0
    var dt: TimeInterval = 0
    
    override func didMove(to view: SKView) {
        
        // THE GAME SCENE
        // ---------------------
        // set the physics properties of this world
        
        
    }
    
    func makePlatform(xPosition:CGFloat, yPosition:CGFloat) {
        let platform = SKSpriteNode(imageNamed: "Ground")
        
        platform.position.x = xPosition / 2;
        platform.position.y = yPosition / 2;
        
        
        addChild(platform)
    }
    
    
    
    func spawnmario() {
        let mario = SKSpriteNode(imageNamed:"mario")
        
        // put sand at a random (x,y) position
        let x = self.size.width / 2
        let y = self.size.height - 100
        
        mario.position.x = x / 2
        mario.position.y = y / 2
        
        // add physics
        mario.physicsBody = SKPhysicsBody(circleOfRadius: mario.size.width / 2)
        self.mario.physicsBody?.affectedByGravity = true
        
        addChild(mario)
    }
    
   
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first!
        if (touch == nil) {
            return
        }
        
        let location = touch.location(in:self)
        let node = self.atPoint(location)
        
        if (node.name == "nextLevelButton") {
            let scene = SKScene(fileNamed:"Level2")
            if (scene == nil) {
                print("Error loading level")
                return
            }
            else {
                scene!.scaleMode = .aspectFill
                view?.presentScene(scene!)
            }
        }
        
        
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
     
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
        self.dt = currentTime - timeOfLastUpdate
        if (self.dt >= 1.0) {
            timeOfLastUpdate = currentTime
            self.spawnmario()
        }
        
        
    }
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
}
