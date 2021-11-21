//
//  DetailView.swift
//  Project1 WatchKit Extension
//
//  Created by Joel Sereno on 11/18/21.
//

import SwiftUI

struct DetailView: View {
    
    let index: Int
    let note: Note
    let totalNotes: Int
    
    var body: some View {
        Text(note.text)
            .navigationTitle("Note \(index+1) \\ \(totalNotes)") //Places text of our choosing into the navigation space
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(index: 1, note: Note(id: UUID(), text: "Hello, World!"), totalNotes: 3)
    }
}
