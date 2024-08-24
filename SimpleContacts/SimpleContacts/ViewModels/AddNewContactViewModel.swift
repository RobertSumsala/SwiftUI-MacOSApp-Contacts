//
//  AddNewContactViewModel.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 21/07/2024.
//

import Foundation
import CoreData

class AddNewContactViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var number: String = ""
    @Published var email: String = ""
    
    var context: NSManagedObjectContext
    var contactsVM: ContactsViewModel
    
    init(context: NSManagedObjectContext, contactsVM: ContactsViewModel) {
        self.context = context
        self.contactsVM = contactsVM
    }
    
    func save() {
        do {
            let contact = Contact(context: context)
            contact.name = name
            contact.number = self.formatNumber(number: number)
            if !email.isEmpty {
                contact.email = email
            }
            contact.isFavourited = false
            try contact.save()
            contactsVM.sort()
        } catch {
            print(error)
        }
    }
    
    private func formatNumber(number: String) -> String {
        
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
