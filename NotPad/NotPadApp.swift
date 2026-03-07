//
//  NotPadApp.swift
//  NotPad
//
//  Created by Cem Akkaya on 25/02/26.
//

import SwiftUI
import CoreData

@main
struct NotPadApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NoteView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
