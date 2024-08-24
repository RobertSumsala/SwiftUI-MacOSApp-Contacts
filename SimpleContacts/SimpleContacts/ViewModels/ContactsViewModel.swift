//
//  ContactsViewModel.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 17/07/2024.
//

import Foundation
import CoreData
import SwiftUI

class ContactsViewModel: NSObject, ObservableObject {
    @Published var contacts = [ContactViewModel]()
    private let fetchResultController: NSFetchedResultsController<Contact>
    private let context: NSManagedObjectContext
    
    private var sortAscending: Bool = true

    @Published var saveTriggered = false
    
    
    
    init(context: NSManagedObjectContext) {
        
        self.context = context
        fetchResultController = NSFetchedResultsController(fetchRequest: Contact.all, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        fetchResultController.delegate = self
        
        setupObservers()
        
        fetchAll()
    }
    
    
    
    private func setupObservers() {
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(managedObjectContextObjectsDidChange), name: NSNotification.Name.NSManagedObjectContextObjectsDidChange, object: context)
    }
    
    @objc func managedObjectContextObjectsDidChange(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        
        if let updates = userInfo[NSUpdatedObjectsKey] as? Set<Contact>, updates.count > 0 {
            fetchAll()
        }
    
    }
    
    var allContactsCount: Int {
        contacts.count
    }
    
    func delete(_ contact: ContactViewModel) {
        let contact: Contact? = Contact.byId(id: contact.id)
        if let contact = contact {
            try? contact.delete()
            sort()
        }
    }
    
    func triggerSave() {
        saveTriggered = true
    }
    
    func setSortStyle(sortAscending: Bool){
        self.sortAscending = sortAscending
    }
    func sort() {
        if self.sortAscending {
            contacts = contacts.sorted { $0.name < $1.name }
        } else {
            contacts = contacts.sorted { $0.name > $1.name }
        } 
    }
    
      
    private func fetchAll() {
        do {
            try fetchResultController.performFetch()
            guard let contacts = fetchResultController.fetchedObjects else {
                return
            }
            
            self.contacts = contacts.map(ContactViewModel.init )
            sort()
            
        } catch {
            print(error)
        }
        
    }
}

extension ContactsViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let contacts = controller.fetchedObjects as? [Contact] else {
            return
        }
        
        self.contacts = contacts.map(ContactViewModel.init)
    }
    
    
}
