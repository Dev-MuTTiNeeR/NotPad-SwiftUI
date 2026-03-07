//
//  NoteDetailView.swift
//  NotPad
//
//  Created by Cem Akkaya on 25/02/26.
//

import SwiftUI
import CoreData

struct NoteDetailView: View {
    
    @ObservedObject var note: Note
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack {
            
            TextField("Write here...", text: Binding(
                get: { note.title ?? "" },
                set: { note.title = $0 }
            ))
            .font(.title)
            .bold()
            .padding()
            
            TextEditor(text: Binding(
                get: { note.content ?? "" },
                set: { note.content = $0}
            ))
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            do {
                try context.save()
                print("Changes have been successfully saved!")
            } catch {
                print("Saving error: \(error)")
            }
        }
    }
}

//#Preview {
//    NoteDetailView()
//}
