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
    
    let moves = ["rock", "paper", "scissors"]
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect() //autoconnect tells the timer to start publishing its time announcements immediately
    
    
    //MARK: - View
    var body: some View {
        VStack {
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
        }
        .navigationTitle(title)
        .onAppear(perform: newLevel)
        .onReceive(timer) { newTime in
            currentTime = newTime
        }
    }
    
    //MARK: - Functions
    func select(move: String){
        
    }
    
    func newLevel() {
        if Bool.random() {
            title = "Win!"
            shouldWin = true
        } else {
            title = "Lose!"
            shouldWin = false
        }
        
        question = moves.randomElement()! //force unwrap, but we know it is safe to do so
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
