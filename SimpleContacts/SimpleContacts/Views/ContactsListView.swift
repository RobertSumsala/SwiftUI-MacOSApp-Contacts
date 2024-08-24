//
//  ContactsListView.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 20/07/2024.
//

import SwiftUI

struct ContactsListView: View {
    
    @StateObject var vm: ContactsViewModel
    @Binding var selectedContact: ContactViewModel?
    
    init(vm: ContactsViewModel, selectedContact: Binding<ContactViewModel?>) {
        _vm = StateObject(wrappedValue: vm)
        self._selectedContact = selectedContact
    }
    
    var body: some View {
        if vm.contacts.isEmpty {
            Text("No Contacts Available")
        }
        
        List {
            ForEach(vm.contacts) { contact in
                VStack(alignment: .leading) {
                    Text(contact.name)
                        .font(.title)
                        .bold()
                    Text(contact.number)
                        .font(.system(size: 13))
                        .opacity(0.4)
                    Divider()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedContact = contact
                }
            }
        }
    }
}

struct ContactsListView_Previews: PreviewProvider {
    @State static var selectedContact: ContactViewModel? = nil
    static var previews: some View {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        return ContactsListView(vm: ContactsViewModel(context: context), selectedContact: $selectedContact)
    }
}
