//
//  ContactViewModel.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 17/07/2024.
//

import Foundation
import CoreData
import SwiftUI

class ContactViewModel: Identifiable, ObservableObject {
    
    private let contact: Contact
    
    init(c: Contact) {
        
        self.contact = c
    }
    
    
    
    var id: NSManagedObjectID {
        contact.objectID
    }
    
    var photo: NSImage {
        contact.photo ?? NSImage(systemSymbolName: Constants.Icons.personCircleFill, accessibilityDescription: nil)!
    }
    
    var name: String {
        contact.name ?? ""
    }
    
    var number: String {
        contact.number ?? ""
    }
    
    var email: String {
        contact.email ?? ""
    }
    
    var isFavourited: Bool {
        contact.isFavourited
    }
    
    
}
