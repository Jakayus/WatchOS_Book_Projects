//
//  GameScene.swift
//  Project11 WatchKit Extension
//
//  Created by Joel Sereno on 1/2/22.
//

import SpriteKit
import WatchKit

class GameScene: SKScene, WKCrownDelegate {

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
    
    func createPlayer(color: String) -> SKSpriteNode {
        
        //load a node
        let component = SKSpriteNode(imageNamed: "player\(color)")
        
        //name the node its color
        component.name = color
        
        //add this node to the parent node
        player.addChild(component)
        
        return component
    }
    
    func setUp() {
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
    
}
