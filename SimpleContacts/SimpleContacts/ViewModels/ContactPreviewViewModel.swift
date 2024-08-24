//
//  ContactPreviewViewModel.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 28/07/2024.
//

import Foundation
import AppKit


class ContactPreviewViewModel: ObservableObject {
    var name: String
    var number: String
    var email: String
    var isFavourited: Bool
    var update: Bool = false
    var photo: NSImage
    
    init(name: String, number: String, email: String, isFavourited: Bool, photo: NSImage) {
        self.name = name
        self.number = number
        self.email = email
        self.isFavourited = isFavourited
        self.photo = photo
    }
}
