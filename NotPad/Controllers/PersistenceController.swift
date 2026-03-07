//
//  PersistenceController.swift
//  NotPad
//
//  Created by Cem Akkaya on 25/02/26.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "NotPadModel")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Database could not be loaded: \(error), \(error.userInfo)")
            }
        }
    }
}
