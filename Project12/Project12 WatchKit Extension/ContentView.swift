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
            Text("Response Text")
            Button("Message", action: sendMessage)
        }
    }
    
    //MARK: - Methods
    func sendMessage() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
