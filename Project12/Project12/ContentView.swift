//
//  ContentView.swift
//  Project12
//
//  Created by Joel Sereno on 1/15/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack(spacing: 30) {
            Button("Message", action: sendMessage)
            Button("Context", action: sendContext)
            Button("File", action: sendFile)
            Button("Complication", action: sendComplication)
        }
    }
    
    //MARK: - Methods
    func sendMessage() {
        
    }
    
    func sendContext() {
        
    }
    
    func sendFile() {
        
    }
    
    func sendComplication() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
