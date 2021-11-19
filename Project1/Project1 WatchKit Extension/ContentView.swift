//
//  ContentView.swift
//  Project1 WatchKit Extension
//
//  Created by Joel Sereno on 10/31/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var notes = [Note]() //"this property represents the active, changing state of my porogram, and I want SwiftUI to manage it"
    @State private var text = ""  //@State automatically creates a binding for our property that we can use anywhere we need to both read and write the value
    
    
    var body: some View {
        VStack {
            HStack {
                TextField("Add new note", text: $text)
                
                Button{
                    guard text.isEmpty == false else { return }
                    
                    let note = Note(id: UUID(), text: text)
                    notes.append(note)
                    
                    text = ""
                    
                }  label: {
                    Image(systemName: "plus")
                        .padding()
                }
                .fixedSize()
                .buttonStyle(BorderedButtonStyle(tint: .teal))
            }
            
            List(0..<notes.count, id: \.self) { i in // the "\.self" means the number itself will be unique
                
                NavigationLink(destination: DetailView(index: i, note: notes[i])) {
                    Text(notes[i].text)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
