//
//  EditContactViewModel.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 23/07/2024.
//

import Foundation
import CoreData
import AppKit

class EditContactViewModel: ObservableObject {
    
    var contactVM: ContactViewModel
    
    @Published var wasEdited: Bool = false
    
    @Published var name: String = ""
    @Published var number: String = ""
    @Published var email: String = ""
    @Published var isFavourited: Bool
    @Published var nameBeforeEdit: String = ""
    @Published var numberBeforeEdit: String = ""
    @Published var emailBeforeEdit: String = ""
    @Published var isSetForDeletion: Bool = false
    @Published var id: NSManagedObjectID
    @Published var photo: NSImage
    @Published var photoBeforeEdit: NSImage
    
    init(contactVM: ContactViewModel) {
        self.contactVM = contactVM
        self.name = contactVM.name
        self.number = contactVM.number
        self.email = contactVM.email
        self.isFavourited = contactVM.isFavourited
        self.photo = contactVM.photo
        self.nameBeforeEdit = contactVM.name
        self.numberBeforeEdit = contactVM.number
        self.emailBeforeEdit = contactVM.email
        self.id = contactVM.id
        self.photoBeforeEdit = contactVM.photo
    }
    
    
    func save() {
        let contact: Contact? = Contact.byId(id: contactVM.id)
        if let contact = contact {
            contact.name = name
            contact.number = self.formatNumber(number: number)
            contact.email = email
            contact.isFavourited = isFavourited
            contact.photo = photo
            try? contact.save()
        }
    }
    
    func delete() {
        print("Deleteing contact")
        print(contactVM.name)
        let contact: Contact? = Contact.byId(id: contactVM.id)
        if let contact = contact {
            try? contact.delete()
        }
    }
    
    func setForDelete() {
        self.isSetForDeletion.toggle()
    }
    
    func formatNumber(number: String) -> String {
        
        var formatedNumber = number.replacingOccurrences(of: " ", with: "")
        
        func insertSpacesAfter(after index: Int, in number: inout String){
            let position = number.index(number.startIndex, offsetBy: index)
            if number.count > index {
                number.insert(" ", at: position)
            }
        }
        
        if (formatedNumber.hasPrefix("+") && formatedNumber.count >= 13) || (!formatedNumber.hasPrefix("+") && formatedNumber.count >= 10) {
            insertSpacesAfter(after: 4, in: &formatedNumber)
            insertSpacesAfter(after: 8, in: &formatedNumber)
            
            if formatedNumber.hasPrefix("+") {
                insertSpacesAfter(after: 12, in: &formatedNumber)
            }
        }
        
        
        return formatedNumber
    }
    
}
