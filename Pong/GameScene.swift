//
//  GameScene.swift
//  Pong
//
//  Created by Tyler Reinert on 5/12/17.
//  Copyright © 2017 Tyler Reinert. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //declare variables
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    
    var toplbl = SKLabelNode()
    var bottomlbl = SKLabelNode()
    
    var score = [Int]()
    
    
    override func didMove(to view: SKView) {
        
        
        startGame()
        
        toplbl = self.childNode(withName: "toplabel") as! SKLabelNode
        bottomlbl = self.childNode(withName: "bottomlabel") as! SKLabelNode
        
        //add paddles and ball
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        
        
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        
        
        //build border
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
    }
    
    
    func startGame() {
        score = [0,0]
        toplbl.text = "\(score[1])"
        bottomlbl.text = "\(score[0])"
    }
    
    
    func addScore(playerWhoWon : SKSpriteNode){
        // reset ball if player loses
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        
        if playerWhoWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
            
        }
        
        else if playerWhoWon == enemy{
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
            
        }
        //print(score)
        
        //update score labels
        toplbl.text = "\(score[1])"
        bottomlbl.text = "\(score[0])"

    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
        
        if ball.position.y <= main.position.y - 70{
            
            addScore(playerWhoWon: enemy)
            
        }
        
        else if ball.position.y >= enemy.position.y + 70 {
            
            addScore(playerWhoWon: main)
            
            
        }
        
    }
}
