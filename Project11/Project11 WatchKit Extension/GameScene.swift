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
    }
    
    override func didChangeSize(_ oldSide: CGSize) {
        guard size.width > 100 else { return }
        guard player.children.isEmpty else { return }
        
        setUp()
    }
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        player.zRotation -= CGFloat(rotationalDelta) * 20
    }
    
}
