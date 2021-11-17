//
//  ContentView.swift
//  Project1 WatchKit Extension
//
//  Created by Joel Sereno on 10/31/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var notes = [Note]()
    
    var body: some View {
        VStack {
            Button("Add Note") {
                let note = Note(id: UUID(), text: "Example")
                notes.append(note)
            }
            // \.self = "the number itself will be unique"
            List(0..<notes.count, id: \.self) { i in
                Text(notes[i].text)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
