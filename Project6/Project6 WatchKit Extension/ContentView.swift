//
//  ContentView.swift
//  Project6 WatchKit Extension
//
//  Created by Joel Sereno on 12/18/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var useRedText = false
    
    var body: some View {
        
        //example 1
//        Text("Hello, World!")
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color.red)
//            .ignoresSafeArea()
        
        //example 2
//        Button("Hello World") {
//            print(type(of: self.body))
//        }
//        .frame(width: 150)
//        .background(Color.red)
        
        //example 3
//        Text("Hello World")
//            .padding()
//            .background(Color.red)
//            .padding()
//            .background(Color.blue)
//            .padding()
//            .background(Color.green)
//            .padding()
//            .background(Color.yellow)
        
        Button("Press Me") {
            //flip the Boolean between true and false
            self.useRedText.toggle()
        }
        .foregroundColor(useRedText ? .red : .blue)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
