//
//  SimpleContactsApp.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 17/07/2024.
//

import SwiftUI

@main
struct SimpleContactsApp: App {
    var body: some Scene {
        WindowGroup {
            let viewContext = CoreDataManager.shared.persistentContainer.viewContext
            HomeScreen().environment(\.managedObjectContext, viewContext)
        }
    }
}
