//
//  InterfaceController.swift
//  Project11 WatchKit Extension
//
//  Created by Joel Sereno on 1/2/22.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    var gameScene: GameScene!
    
    @IBOutlet weak var gameInterface: WKInterfaceSKScene! //outlets are properties, and actions are methods
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        
        //WatchKit equivalent of SwiftUI's onAppear
        
        startGame(self) //this mean scurrent screen is making the method call
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

    @IBAction func startGame(_ sender: Any) {
        
        gameScene = GameScene()
        gameScene.scaleMode = .resizeFill //allows design to scale across all sizes
        gameScene.anchorPoint = CGPoint(x: 0.5, y: 0.5) //center
        
        gameInterface.presentScene(gameScene) // show scene immediately
        
    }
}
