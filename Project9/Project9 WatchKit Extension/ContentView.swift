//
//  ContentView.swift
//  Project9 WatchKit Extension
//
//  Created by Joel Sereno on 12/29/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        Button("Tap Me") {
            //animationAmount += 0.25
        }
        .buttonStyle(PlainButtonStyle())
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
       

        //.animation(.easeInOut(duration: 2), value: animationAmount) // replaces .animation(.default)
        .overlay (
            Circle()
                .strokeBorder(Color.red)
                .scaleEffect(animationAmount)
                .opacity(Double(2 - animationAmount))
                .animation(
                    Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: false)
                    , value: animationAmount)
        )
        .onAppear(perform: {
            animationAmount = 2
        })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
