//
//  ContentView.swift
//  NotPad
//
//  Created by Cem Akkaya on 25/02/26.
//

import SwiftUI
import CoreData

struct NoteView: View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Note.title, ascending: true)], animation: .default)
    var notes: FetchedResults<Note>
    @Environment(\.managedObjectContext) var context
    @State private var path = [Note]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List{
                ForEach(notes) { note in
                    NavigationLink(value: note) {
                        Text(note.title ?? "Unknown Note")
                    }
                }
                .onDelete(perform: deleteNote)
            }
            .navigationDestination(for: Note.self) { selectedNote in
                NoteDetailView(note: selectedNote)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("NotPad")
                        .font(.title)
                        .bold()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        addNewItem()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    func addNewItem() {
        let newNote = Note(context: context)
        newNote.title = ""
        newNote.content = ""
        
        path.append(newNote)
    }
    
    func deleteNote(offsets: IndexSet) {
        for index in offsets {
            let noteToDelete = notes[index]
            context.delete(noteToDelete)
        }
        
        do {
            try context.save()
            print("Note successfully deleted!")
        } catch {
            print("Deletion error: \(error)")
        }
    }
}

#Preview {
    NoteView()
}
