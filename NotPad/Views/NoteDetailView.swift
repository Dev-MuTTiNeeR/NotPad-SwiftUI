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
            
            TextField("Write your note here...", text: Binding(
                get: { note.content ?? "" },
                set: { note.content = $0}
            ))
            .padding()
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .principal) {
                TextField("Write title...", text: Binding(
                    get: { note.title ?? "" },
                    set: { note.title = $0 }
                ))
                .font(.title)
                .bold()
                .padding()
            }
        }
        .onDisappear {
            if (note.title ?? "").isEmpty && (note.content ?? "").isEmpty {
                context.delete(note)
            }
            
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
