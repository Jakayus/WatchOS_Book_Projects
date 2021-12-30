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
        print(animationAmount)
        return VStack{
            Slider (value: $animationAmount.animation(
                Animation.easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
            ), in: 1...2, step: 0.2)
            
            Spacer()
            
            Button("Tap Me") {
                animationAmount = 1
            }
            .buttonStyle(PlainButtonStyle())
            .padding(40)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
