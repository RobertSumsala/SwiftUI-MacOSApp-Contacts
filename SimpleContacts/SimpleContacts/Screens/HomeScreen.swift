//
//  HomeScreen.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 17/07/2024.
//

import SwiftUI

struct HomeScreen: View {
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext

    @State var selectedContactForPreview: ContactViewModel? = nil
    @State var selectedContactForEditPreview: EditContactViewModel? = nil
    @State var saveTriggered: Bool = false
    @State var normalPreview: Bool? = true
    
    
    
    var body: some View {
        @State var contactsVM: ContactsViewModel = ContactsViewModel(context: context)
        @State var editContactsVM: EditContactsViewModel = EditContactsViewModel(contactsVM: contactsVM)
        
        
        NavigationSplitView{
            ContactsView(contactsVM: contactsVM, editContactsVM: editContactsVM, selectedContact: $selectedContactForPreview, selectedContactForEdit: $selectedContactForEditPreview, normalPreview: $normalPreview, saveTriggered: $saveTriggered)
                .frame(minWidth: 380)
        } detail: {
            if let normalPreview = normalPreview {
                if normalPreview {
                    if let selectedContactForPreview = selectedContactForPreview {
                        ContactPreviewView(c: selectedContactForPreview)
                    } else {
                        Text("Contact Preview")
                    }
                } else {
                    if let selectedContactForEditPreviewUnwrapped = selectedContactForEditPreview {
                        VStack {
                            EditPfpView(editContactViewModel: selectedContactForEditPreviewUnwrapped)
                            
                            EditContactView(editContactVM: selectedContactForEditPreviewUnwrapped, onDone: {
                                selectedContactForEditPreview = nil
                            }, onCanceled: {
                                selectedContactForEditPreview = nil
                            })
                        }
                        .padding(.top, 50)
                        
                    } else {
                        Text("Edit Preview")
                    }
                }
            }
        }
        .frame(minWidth: 500, minHeight: 550)
    }
}

#Preview {
    HomeScreen()
}
