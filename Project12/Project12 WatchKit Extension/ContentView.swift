//
//  ContentView.swift
//  Project12 WatchKit Extension
//
//  Created by Joel Sereno on 1/15/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var connectivity = Connectivity()
    
    var body: some View {
        VStack{
            Text(connectivity.receivedText)
            Button("Message", action: sendMessage)
        }
    }
    
    //MARK: - Methods
    func sendMessage() {
        let data = ["text": "Hello from the watch"]
        connectivity.transferUserInfo(data)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
