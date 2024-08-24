//
//  ContactsListViewModel.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 23/07/2024.
//

import Foundation

class ContactsListViewModel: ObservableObject {
    @Published var saveTriggered: Bool = false
    
    func triggerSave() -> Void {
        saveTriggered = true
    }
    
    func resetSave() -> Void {
        saveTriggered = false
    }
    
}
