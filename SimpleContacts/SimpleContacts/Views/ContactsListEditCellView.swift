//
//  ContactsListEditCellView.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 23/07/2024.
//

import SwiftUI

struct ContactsListEditCellView: View {
    
    private var contact: ContactViewModel
    
    @ObservedObject var editContactVM: EditContactViewModel
    
    @Binding var selectedContactForEdit: EditContactViewModel?
    
    
    init(contact: ContactViewModel, editContactsVM: EditContactsViewModel, selectedContactForEdit: Binding<EditContactViewModel?>) {
        self.contact = contact
        self.editContactVM = editContactsVM.getContactById(id: contact.id)
        self._selectedContactForEdit = selectedContactForEdit
    }
    
    var body: some View {
        HStack{
            ZStack {
                Rectangle()
                    .foregroundColor(.red)
                    .frame(width: 44, height: 44)
                Image(systemName: Constants.Icons.trash)
                    .font(.title)
            }.padding(.trailing, 8)
                .onTapGesture {
                    selectedContactForEdit = editContactVM
                    editContactVM.wasEdited = true
                    editContactVM.setForDelete()
                }
            
            ZStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(editContactVM.name)
                            .font(.title)
                            .bold()
                        Text(editContactVM.number)
                            .font(.system(size: 13))
                            .opacity(0.4)
                    }
                    
                    Spacer()
                    
                    if !editContactVM.isSetForDeletion {
                        Image(systemName: editContactVM.isFavourited ? Constants.Icons.starFill : Constants.Icons.star)
                            .font(.title)
                            .onTapGesture {
                                editContactVM.wasEdited = true
                                editContactVM.isFavourited.toggle()
                            }
                        Image(systemName: Constants.Icons.pencil)
                            .font(.title)
                            .onTapGesture {
                                selectedContactForEdit = editContactVM
                            }
                    }
                }
                if editContactVM.isSetForDeletion {
                    Rectangle()
                        .foregroundColor(.red)
                        .opacity(0.8)
                    VStack(alignment: .trailing){
                        Text("Set To Be Deleted")
                            .foregroundColor(.white)
                    }
                }
                
            }
            
            
        }
        
        
    }
    
}

struct ContactsListEditCellView_Previews: PreviewProvider {
    @State static var selConForEdit: EditContactViewModel? = nil
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistentContainer.viewContext
        return ContactsListEditCellView(contact: ContactViewModel(c: Contact()), editContactsVM: EditContactsViewModel(contactsVM: ContactsViewModel(context: viewContext)), selectedContactForEdit: $selConForEdit)
    }
}
