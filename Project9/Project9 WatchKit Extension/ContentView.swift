//
//  ContentView.swift
//  Project9 WatchKit Extension
//
//  Created by Joel Sereno on 12/29/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount = 0.0
    
    var body: some View {
        
        Button("Tap Me") {
            //explicit animation
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)){
                animationAmount += 360
            }
        }
        .buttonStyle(PlainButtonStyle())
        .padding(40)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 1, y: 1, z: 1))
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
