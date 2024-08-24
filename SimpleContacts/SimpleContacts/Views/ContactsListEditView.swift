//
//  ContactsListEditView.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 22/07/2024.
//

import SwiftUI

struct ContactsListEditView: View {
    
    @StateObject var vm: ContactsViewModel
    
    var editContactsViewModel: EditContactsViewModel
    @State var saveActive: Bool = false
    
    @Binding var selectedContactForEdit: EditContactViewModel?
    
    
    init(vm: ContactsViewModel, editContactsViewModel: EditContactsViewModel, selectedContactForEdit: Binding<EditContactViewModel?>) {
        _vm = StateObject(wrappedValue: vm)
        self.editContactsViewModel = editContactsViewModel
        self._selectedContactForEdit = selectedContactForEdit
    }
    
    var body: some View {
        List {
            ForEach(vm.contacts, id: \.id) { contact in
                ContactsListEditCellView(contact: contact, editContactsVM: editContactsViewModel, selectedContactForEdit: $selectedContactForEdit)
                Divider()
            }
        }
    }
}

struct ContactsListEditView_Previews: PreviewProvider {
    @State static var selContForEdit: EditContactViewModel? = nil
    static var previews: some View {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        return ContactsListEditView(vm: ContactsViewModel(context: context), editContactsViewModel: EditContactsViewModel(contactsVM: ContactsViewModel(context: context)), selectedContactForEdit: $selContForEdit)
    }
}
