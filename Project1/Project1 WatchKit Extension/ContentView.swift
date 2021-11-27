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
                    notes.append(note) //append the note
                    totalNotes += 1

                    text = ""
                    save()
                    
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
                
                NavigationLink (destination: CreditsView()) {
                    HStack{
                        Text("Credits")
                        Image(systemName: "c.circle")
                            .foregroundColor(.teal)
                    }
                }
            }
        }
        .navigationTitle("NoteDictate")
        .onAppear(perform: load)
    }

    
    //MARK: - Methods
    func delete(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
        }
        save()
        if totalNotes > 0 {
            totalNotes -= 1
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func save() {
        do {
            //1. use JSONEncoder to convert notes into Data instance
            //2. create a new URL to save to our file, using getDocumentsDirectory function
            //3. write data to URL
            
            
            let data = try JSONEncoder().encode(notes)
            let url = getDocumentsDirectory().appendingPathComponent("notes")
            try data.write(to: url)
        } catch {
            print("Save failed")
        }
    }//end save func
    
    func load() {
        DispatchQueue.main.async {
            do {
                //1. make the file URL
                //2. create a Data instance by loading it
                //3. use JSONDecoder to convert data into an array of Note objects
                
                let url = getDocumentsDirectory().appendingPathComponent("notes")
                let data = try Data(contentsOf: url)
                notes = try JSONDecoder().decode([Note].self, from: data)
            } catch {
                //do nothing
                //not an issue if no file is found, because that will be the case if file does not exist
            }
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
