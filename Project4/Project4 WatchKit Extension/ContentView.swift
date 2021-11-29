//
//  ContentView.swift
//  Project4 WatchKit Extension
//
//  Created by Joel Sereno on 11/27/21.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = 500.0
    
    var body: some View {
        VStack {
            Text("\(Int(amount))")
                .font(.system(size: 52))
            Slider(value: $amount, in: 0...1000, step: 20)
            //Slider notes
            //1. move between 0 and 1000 inclusive
            //2. sets the step count to 20 (up/down by 20)
            //3. two way binding for amount property
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
