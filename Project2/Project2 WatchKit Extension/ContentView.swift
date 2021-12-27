//
//  ContentView.swift
//  Project2 WatchKit Extension
//
//  Created by Joel Sereno on 11/21/21.
//

import SwiftUI

//NOTE:
//Text("Icons from icons8.com")
  //  .padding()

struct ContentView: View {
    
    //MARK: - Properties
    @State private var question = "rock"
    @State private var title = "Win"
    
    @State private var shouldWin = true
    @State private var level = 1
    
    @State private var currentTime = Date()
    @State private var startTime = Date()
    
    @State  private var gameOver = false //control whether the game is active or not
    
    @State var moves = ["rock", "paper", "scissors"]
    
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect() //autoconnect tells the timer to start publishing its time announcements immediately
    
    var time: String {
        let difference = currentTime.timeIntervalSince(startTime)
        return String(Int(difference))
    }
    
    
    @State var isCorrect: Bool
    @State var colorActive = false
    
    
    //change color based upon whether answer is correct
    var answerColor: Color {
        if isCorrect {
            return .green
        } else {
            return .red
        }
    }
    
    //if answerColor is active, set color to designated color, otherwise default is applied
    var currentColor: Color {
        if colorActive {
            return answerColor
        } else {
            return Color.primary
        }
    }
    
    
    
    
    //MARK: - View
    var body: some View {
        VStack {
            if gameOver {
                Text("You win!")
                    .font(.largeTitle)
                Text("Your time: \(time) seconds")
                
                Button("Play Again") {
                    startTime = Date()
                    gameOver = false
                    level = 1
                    newLevel()
                }
                .buttonStyle(BorderedButtonStyle(tint: .green))
            } else {
                Image(question)
                    .resizable()
                    .scaledToFit()
                Divider()
                    .padding(.vertical)
                //HStack for 3 buttons
                HStack{
                    ForEach(moves, id: \.self){ type in
                        Button {
                            select(move: type)
                        } label: {
                            Image(type)
                                .resizable()
                                .scaledToFit()
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                    }
                }
                HStack {
                    Text("\(level)/20")
                        .foregroundColor(currentColor)
                    
                    Spacer()
                    Text("Time: \(time)")
                }
                .padding([.top, .horizontal])
            }
        }
        .navigationTitle(title)
        .onAppear(perform: newLevel)
        .onReceive(timer) { newTime in
            guard gameOver == false else { return } //don't continue if game is over
            currentTime = newTime
        }
    }
    
    //MARK: - Functions
    func select(move: String){
        
        let solutions = [
            "rock": (win: "paper", lose: "scissors"),
            "paper": (win: "scissors", lose: "rock"),
            "scissors": (win: "rock", lose: "paper")
        ]
        
        guard let answer = solutions[question] else {
            fatalError("Unknown question: \(question)")
        }
        
        //let isCorrect: Bool
        
        //determine if move is correct answer
        if shouldWin {
            isCorrect = move == answer.win
        } else {
            isCorrect = move == answer.lose
        }
        
        
        colorActive = true
        //use GCD asyncAfter to run code after half second (0.5) delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            colorActive = false
        }
        
        
        //update levels
        if isCorrect {
            level += 1
        } else {
            level -= 1
            if level < 1 { level = 1 }
        }
        
        newLevel()
        
        print(answer)
        print(answerColor)
    }
    
    func newLevel() {
        if level == 21 {
            
            //delay win screen
            //use GCD asyncAfter to run code after half second (0.5) delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                gameOver = true
            }
            
            //gameOver = true
            return
        }
        
        if Bool.random() {
            title = "Win!"
            shouldWin = true
        } else {
            title = "Lose!"
            shouldWin = false
        }
        
        
        var tempQuestion = question
        
        repeat {
            tempQuestion = moves.randomElement()! //force unwrap, but we know it is safe to do so
        } while tempQuestion == question
        
       question = tempQuestion
        
        //reshuffle array
        moves = moves.shuffled()
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView( isCorrect: false)
    }
}
