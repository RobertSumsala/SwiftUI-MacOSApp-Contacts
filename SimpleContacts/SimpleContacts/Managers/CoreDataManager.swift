//
//  CoreDataManager.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 17/07/2024.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    private init(){
        ValueTransformer.setValueTransformer(NSImageTransformer(), forName: NSValueTransformerName("NSImageTransformer"))
        
        persistentContainer = NSPersistentContainer(name: "ContactsModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
}
