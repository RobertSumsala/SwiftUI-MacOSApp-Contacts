//
//  Contact.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 17/07/2024.
//

import Foundation
import CoreData
import AppKit

@objc(Contact)
public class Contact: NSManagedObject, BaseModel {
    
    static var all: NSFetchRequest<Contact> {
        let request: NSFetchRequest<Contact> = Contact.fetchRequest()
        request.sortDescriptors = []
        return request
    }
}

extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var name: String?
    @NSManaged public var number: String?
    @NSManaged public var email: String?
    @NSManaged public var isFavourited: Bool
    @NSManaged public var photo: NSImage?

}

extension Contact : Identifiable {

}
