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
        VStack{
            Divider()
            
            ZStack(alignment: .topLeading) {
                if (note.content ?? "").isEmpty {
                    Text("Write your note...")
                        .foregroundColor(.gray)
                        .padding(.top, 10)
                        .padding(.leading, 5)
                }
                
                TextEditor(text: Binding(
                    get: {note.content ?? ""},
                    set: {note.content = $0}
                ))
                .opacity(0.8)
            }
            .padding(.horizontal)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal) {
                    TextField("Write title...", text: Binding(
                        get: { note.title ?? "" },
                        set: { note.title = $0 }
                    ))
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                    .frame(height: 30)
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
}

//#Preview {
//    NoteDetailView()
//}
