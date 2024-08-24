//
//  ContactPreviewsViewModel.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 28/07/2024.
//

import Foundation

class ContactPreviewsViewModel: ObservableObject {
    @Published var previewsVMs: [ContactPreviewViewModel] = []
    
    init(contactsVM: ContactsViewModel){
        self.contactsVM = contactsVM
    }
}
