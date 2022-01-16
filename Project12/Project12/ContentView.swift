//
//  ContentView.swift
//  Project12
//
//  Created by Joel Sereno on 1/15/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var connectivity = Connectivity()
    
    var body: some View {
        VStack(spacing: 30) {
            Text("\(connectivity.receivedText)")
            Button("Message", action: sendMessage)
            Button("Context", action: sendContext)
            Button("File", action: sendFile)
            Button("Complication", action: sendComplication)
        }
    }
    
    //MARK: - Methods
    func sendMessage() {
        let data = ["text": "Hello from the phone"]
        connectivity.setContext(to: data)
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
