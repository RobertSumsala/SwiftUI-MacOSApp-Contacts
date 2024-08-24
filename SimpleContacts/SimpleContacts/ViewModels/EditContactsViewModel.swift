//
//  EditContactsViewModel.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 23/07/2024.
//

import Foundation
import CoreData

class EditContactsViewModel: ObservableObject {
    
    private var contactsVM: ContactsViewModel
    
    @Published var editContactVMs: [EditContactViewModel] = []
    
    init(contactsVM: ContactsViewModel){
        self.contactsVM = contactsVM
    }
    
    func fetchContacts() {
        self.editContactVMs = []
        for contact in contactsVM.contacts {
            self.editContactVMs.append(EditContactViewModel(contactVM: contact))
        }
    }
    
    func getContactById(id: NSManagedObjectID) -> EditContactViewModel {
        for contact in editContactVMs {
            if contact.id == id {
                return contact
            }
        }
        fatalError("Contact with the given ID not found.")
    }
    
    func update() {
        if !editContactVMs.isEmpty {
            for editContactVM in editContactVMs {
                if editContactVM.wasEdited {
                    editContactVM.save()
                }
            }
            contactsVM.sort()
        }
    }
    
    func cancelDeletes() {
        if !editContactVMs.isEmpty {
            for editContactVM in editContactVMs {
                editContactVM.isSetForDeletion = false
            }
        }
    }
    
    func deleteSelected(selectedContact: ContactViewModel?) -> Bool {
        var selectedContactDeleted: Bool = false
        if !editContactVMs.isEmpty {
            for editContactVM in editContactVMs {
                if editContactVM.isSetForDeletion {
                    if let selectedContact = selectedContact {
                        print("Selected contact not nil")
                        if editContactVM.id == selectedContact.id {
                            selectedContactDeleted = true
                        }
                    }
                    editContactVM.delete()
                }
            }
            contactsVM.sort()
        }
        return selectedContactDeleted
    }
    
}
