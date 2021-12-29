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
            animationAmount += 0.25
        }
        .buttonStyle(PlainButtonStyle())
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .blur(radius: (animationAmount - 1) * 3)
        //.animation(.easeInOut(duration: 2), value: animationAmount) // replaces .animation(.default)
        .animation(
            Animation.easeInOut(duration: 1)
                .repeatCount(3, autoreverses: true)
            , value: animationAmount)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
