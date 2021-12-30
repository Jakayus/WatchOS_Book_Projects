//
//  ContentView.swift
//  Project9 WatchKit Extension
//
//  Created by Joel Sereno on 12/29/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isShowingRed = false
    
    var body: some View {
     
        VStack {
            Button("Tap Me") {
                withAnimation {
                    isShowingRed.toggle()
                }
                
            }
            
            if isShowingRed {
                Color.red
                    .frame(width: 100, height: 100)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
