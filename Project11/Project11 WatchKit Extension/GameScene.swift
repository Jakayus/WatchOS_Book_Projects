//
//  GameScene.swift
//  Project11 WatchKit Extension
//
//  Created by Joel Sereno on 1/2/22.
//

import SpriteKit
import WatchKit

class GameScene: SKScene, WKCrownDelegate, SKPhysicsContactDelegate {

    let player = SKNode()
    
    let leftEdge = SKSpriteNode(color: UIColor.white, size: CGSize(width: 10, height: 150))
    let rightEdge = SKSpriteNode(color: UIColor.white, size: CGSize(width: 10, height: 150))
    let topEdge = SKSpriteNode(color: UIColor.white, size: CGSize(width: 150, height: 10))
    let bottomEdge = SKSpriteNode(color: UIColor.white, size: CGSize(width: 150, height: 10))
    
    var isPlayerAlive = true
    let colorNames = ["Red", "Blue", "Green", "Yellow"]
    let colorValues: [UIColor] = [.red, .blue, .green, .yellow]
    var alertDelay = 1.0
    var moveSpeed = 70.0
    
    var createDelay = 0.5
    
    func createPlayer(color: String) -> SKSpriteNode {
        
        //load a node
        let component = SKSpriteNode(imageNamed: "player\(color)")
        
        component.physicsBody = SKPhysicsBody(texture: component.texture!, size: component.size)
        component.physicsBody?.isDynamic = false
        
        //name the node its color
        component.name = color
        
        //add this node to the parent node
        player.addChild(component)
        
        return component
    }
    
    func setUp() {
        
        physicsWorld.contactDelegate = self
        
        backgroundColor = .black
        
        let red = createPlayer(color: "Red")
        red.position = CGPoint(x: -8, y: 8)
        
        let blue = createPlayer(color: "Blue")
        blue.position = CGPoint(x: 8, y: 8)
        
        let green = createPlayer(color: "Green")
        green.position = CGPoint(x: -8, y: -8)
        
        let yellow = createPlayer(color: "Yellow")
        yellow.position = CGPoint(x: 8, y: -8)
        
        addChild(player)
        
        leftEdge.position = CGPoint(x: -50, y: 0)
        rightEdge.position = CGPoint(x: 50, y: 0)
        topEdge.position = CGPoint(x: 0, y: 50)
        bottomEdge.position = CGPoint(x: 0, y: -50)
        
        for edge in [leftEdge, rightEdge, topEdge, bottomEdge] {
            edge.colorBlendFactor = 1 //1 = full replacement color, 0 is original color
            edge.alpha = 0
            addChild(edge)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + createDelay) {
            self.launchBall()
        }
    }
    
    override func didChangeSize(_ oldSide: CGSize) {
        guard size.width > 100 else { return }
        guard player.children.isEmpty else { return }
        
        setUp()
    }
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        player.zRotation -= CGFloat(rotationalDelta) * 20
    }
    
    func pickEdge() -> (position: CGPoint, force: CGVector, edge: SKSpriteNode) {
        let direction = Int.random(in: 0...3)
        
        //return sa tuple with position, force, and edge
        
        switch direction {
        case 0:
            return (CGPoint(x: -110, y: 0), CGVector(dx: moveSpeed, dy: 0), leftEdge)
        
        case 1:
            return (CGPoint(x: 110, y: 0), CGVector(dx: -moveSpeed, dy: 0), rightEdge)
        
        case 2:
            return (CGPoint(x: 0, y: -120), CGVector(dx: 0, dy: moveSpeed), bottomEdge)
            
        default:
            return (CGPoint(x:0, y: 120), CGVector(dx: 0, dy: -moveSpeed), topEdge)
                        
        }
    }
    
    func createBall(color: String) -> SKSpriteNode {
        
        let ball = SKSpriteNode(imageNamed: "ball\(color)")
        ball.name = color
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 12)
        ball.physicsBody!.linearDamping = 0
        ball.physicsBody!.affectedByGravity = false
        ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
        
        addChild(ball)
        return ball
    }
    
    func launchBall() {
        //bail out if the game is over
        guard isPlayerAlive else { return }
        
        //pick a random ball color
        let ballType = Int.random(in: 0 ..< colorNames.count - 1)
        
        //create a ball from that random color
        let ball = createBall(color: colorNames[ballType])
        
        //get a random edge to launch from, plus position and force to apply
        let (position, force, edge) = pickEdge()  //this takes values from pickEdge() and assigns them to position, force, and edge respectively. this is known as destructuring
        
        //place the ball at its starting position
        ball.position = position
        
        let flashEdge = SKAction.run {
            edge.color = self.colorValues[ballType]
            edge.alpha = 1
        }
        
        let resetEdge = SKAction.run {
            edge.alpha = 0
        }
        
        let launchBall = SKAction.run {
            ball.physicsBody!.velocity = force
        }
        
        //pass an array of actions to SKAction.sequence()
        let sequence = SKAction.sequence([flashEdge, SKAction.wait(forDuration: alertDelay), resetEdge, launchBall])
        
        run(sequence)
        alertDelay *= 0.98
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.parent == self {
            ball(nodeA, hit: nodeB)
        } else if nodeB.parent == self {
            ball(nodeB, hit: nodeA)
        } else {
            //neither? just exit
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + createDelay) {
            self.launchBall()
        }
    }
    
    func ball(_ ball: SKNode, hit color: SKNode) {
        
    }
    
}
