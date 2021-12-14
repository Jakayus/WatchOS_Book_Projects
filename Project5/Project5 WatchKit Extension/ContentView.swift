//
//  ContentView.swift
//  Project5 WatchKit Extension
//
//  Created by Joel Sereno on 12/12/21.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - Properties
    let colors = [
        "Red": Color(red:1, green: 0, blue: 0),
        "Green": Color(red: 0, green: 0.5, blue: 0),
        "Blue": Color(red: 0, green: 0, blue: 1),
        "Orange": Color(red: 1, green: 0.6, blue: 0),
        "Purple": Color(red: 0.5, green: 0, blue: 0.5),
        "Black" : Color.black
    ]
    
    @State private var colorKeys = ["Red", "Green", "Blue", "Orange", "Purple", "Black"]
    @State private var correctAnswer = 0
    @State private var currentLevel = 0
    @State private var gameOver = false
    @State private var title = ""
    
    //MARK: - View
    var body: some View {
        VStack(spacing: 10) {
            HStack (spacing: 10){
                text(for: 0)
                text(for: 1)
            }
            HStack (spacing: 10) {
                text(for: 2)
                text(for: 3)
            }
        }
        .navigationTitle(title)
        .onAppear(perform: startNewGame)
    }
    
    //MARK: - Methods
    //NOTE: this function returns a View, which is then used within the View property above
    func text(for index: Int) -> some View {
        let title = colorKeys[index]
        
        return Text(title)
            .frame(maxWidth: .infinity, maxHeight: .infinity) //.infinity takes up all available space
            .background(colors[colorKeys[index]]) //modifier order matters - apply frame THEN background
            .cornerRadius(20)
            
    }
    
    func createLevel() {
        title = "Level \(currentLevel)/10"
        
        correctAnswer = Int.random(in: 0...3)
        colorKeys.shuffle()
    }
    
    func startNewGame() {
        currentLevel = 1
        gameOver = false
        createLevel()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
