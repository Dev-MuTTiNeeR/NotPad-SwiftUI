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
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(notes) { note in
                    NavigationLink(destination: NoteDetailView(note: note)) {
                        Text(note.title ?? "Unknown Note")
                    }
                }
                .onDelete(perform: deleteNote)
            }
            .navigationTitle("NotPad")
            .toolbar {
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
        newNote.title = "New Note \(Int.random(in: 1 ... 100))"
        
        do {
            try context.save()
            print("Note successfully added!")
        } catch {
            print("Note couldn't save: \(error)")
        }
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
