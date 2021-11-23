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
    
    @State private var question = "rock"
    @State private var title = "Win"
    
    let moves = ["rock", "paper", "scissors"]
    
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
    }
    
    func select(move: String){
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
