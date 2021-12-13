//
//  ContentView.swift
//  Project5 WatchKit Extension
//
//  Created by Joel Sereno on 12/12/21.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - Properties
    let colors = [
        "Red": Color(red:1, green: 0, blue: 0),
        "Green": Color(red: 0, green: 0.5, blue: 0),
        "Blue": Color(red: 0, green: 0, blue: 1),
        "Orange": Color(red: 1, green: 0.6, blue: 0),
        "Purple": Color(red: 0.5, green: 0, blue: 0.5),
        "Black" : Color.black
    ]
    
    @State private var colorKeys = ["Red", "Green", "Blue", "Orange", "Purple", "Black"]
    
    //MARK: - View
    var body: some View {
        VStack(spacing: 10) {
            HStack (spacing: 10){
                text(for: 0)
                text(for: 1)
            }
            HStack (spacing: 10) {
                text(for: 2)
                text(for: 3)
            }
        }
    }
    
    //MARK: - Methods
    func text(for index: Int) -> some View {
        let title = colorKeys[index]
        
        return Text(title)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(colors[colorKeys[index]]) //modifier order matters - apply frame THEN background
            .cornerRadius(20)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
