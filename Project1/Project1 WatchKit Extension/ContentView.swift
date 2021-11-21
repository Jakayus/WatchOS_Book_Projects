//
//  ContentView.swift
//  Project1 WatchKit Extension
//
//  Created by Joel Sereno on 10/31/21.
//

import SwiftUI

struct ContentView: View {
    @State private var notes = [Note]()
    @State private var text = ""
    @State private var totalNotes = 0
    

    var body: some View {
        VStack {
            HStack {
                TextField("Add new note", text: $text)

                Button {
                    guard text.isEmpty == false else { return }

                    let note = Note(id: UUID(), text: text)
                    notes.append(note)
                    totalNotes += 1

                    text = ""
                } label: {
                    Image(systemName: "plus")
                        .padding()
                }
                .fixedSize()
                .buttonStyle(BorderedButtonStyle(tint: .blue))
            }

            List {
                ForEach(0..<notes.count, id: \.self) { i in
                    NavigationLink(destination: DetailView(index: i, note: notes[i], totalNotes: totalNotes)) {
                        Text(notes[i].text)
                            .lineLimit(3)
                    }
                    
                }
                .onDelete(perform: delete)
                
                Button("Credits") {
                    //TODO: Credits button for HW
                    print("TODO")
                }
            }
        }
        .navigationTitle("NoteDictate")
    }

    func delete(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
        }
        if totalNotes > 0 {
            totalNotes -= 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
