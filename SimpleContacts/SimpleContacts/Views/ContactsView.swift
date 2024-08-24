//
//  ContactsView.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 20/07/2024.
//

import SwiftUI

struct ContactsView: View {
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    
    @State var addNewPopover: Bool = false
    @State var editActive: Bool = false
    @State var favouritesActive: Bool = false
    @State var sortAscendingPicked: Bool = true
    
    @Binding var selectedContact: ContactViewModel?
    @Binding var normalPreview: Bool?
    @Binding var selectedContactForEdit: EditContactViewModel?
    @Binding var saveTriggered: Bool
    
    @StateObject var contactsVM: ContactsViewModel
    
    @StateObject var editContactsVM: EditContactsViewModel
    
    
    init(contactsVM: ContactsViewModel, editContactsVM: EditContactsViewModel, selectedContact: Binding<ContactViewModel?>, selectedContactForEdit: Binding<EditContactViewModel?>, normalPreview: Binding<Bool?>, saveTriggered: Binding<Bool>){
        _contactsVM = StateObject(wrappedValue: contactsVM)
        _editContactsVM = StateObject(wrappedValue: editContactsVM)
        self._selectedContact = selectedContact
        self._normalPreview = normalPreview
        self._selectedContactForEdit = selectedContactForEdit
        self._saveTriggered = saveTriggered
    }
    
    var body: some View {
        
        
        VStack(alignment: .leading) {
            HStack {
                Text("Contacts")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Spacer()
                
                Text("\(contactsVM.allContactsCount)")
                    .font(.title)
            }.padding(.horizontal)
            
            HStack {
                if editActive {
                    Button("Cancel") {
                        selectedContactForEdit = nil
                        editActive = false
                        editContactsVM.cancelDeletes()
                        normalPreview = true
                        saveTriggered = false
                    }
                    Button("Save") {
                        saveTriggered = true
                        selectedContactForEdit = nil
                        editContactsVM.update()
                        if editContactsVM.deleteSelected(selectedContact: selectedContact) {
                            self.selectedContact = nil
                        }
                        contactsVM.sort()
                        editActive = false
                        normalPreview = true
                    }
                } else if favouritesActive {
                    Button("Back") {
                        favouritesActive = false
                        normalPreview = true
                    }
                } else {
                    Button("Edit") {
                        editContactsVM.fetchContacts()
                        editActive = true
                        normalPreview = false
                    }
                }
                
                if !editActive {
                    SortMenuView(onAscending: {
                        contactsVM.setSortStyle(sortAscending: true)
                        contactsVM.sort()
                    }, onDescending: {
                        contactsVM.setSortStyle(sortAscending: false)
                        contactsVM.sort()
                    })
                }
               
                
                Spacer()
                if favouritesActive {
                    Text("Favourites")
                        .font(.title)
                } else {
                    if !editActive {
                        Image(systemName: Constants.Icons.starFill)
                            .font(.title)
                            .onTapGesture {
                                favouritesActive = true
                                if let selectedContactUnwrapped = selectedContact {
                                    if !selectedContactUnwrapped.isFavourited {
                                        selectedContact = nil
                                    }
                                }
                            }
                        Image(systemName: Constants.Icons.plus)
                            .font(.title)
                            .onTapGesture {
                                addNewPopover = true
                            }
                            .popover(isPresented: $addNewPopover, arrowEdge: .bottom, content: {
                                AddNewContactView(vm: AddNewContactViewModel(context: context, contactsVM: contactsVM))
                            })
                    }
                }
            }.padding(.horizontal)
                .padding(.bottom, 10)
            
            Divider()
            
            if editActive {
                ContactsListEditView(vm: contactsVM, editContactsViewModel: editContactsVM, selectedContactForEdit: $selectedContactForEdit)
            } else if favouritesActive {
                ContactsListFavouritesView(vm: contactsVM, selectedContact: $selectedContact)
            } else {
                ContactsListView(vm: contactsVM, selectedContact: $selectedContact)
            }
            

            Spacer()
        }.frame(minWidth: 380)
            
        
    }
}

struct ContactsView_Previews: PreviewProvider {
    @State static var selCont: ContactViewModel? = nil
    @State static var selContForEdit: EditContactViewModel? = nil
    @State static var normalPrev: Bool? = nil
    @State static var saveTriggered: Bool = false
    static var previews: some View {
        
        let viewContext = CoreDataManager.shared.persistentContainer.viewContext
        return ContactsView(contactsVM: ContactsViewModel(context: viewContext), editContactsVM: EditContactsViewModel(contactsVM: ContactsViewModel(context: viewContext)), selectedContact: $selCont, selectedContactForEdit: $selContForEdit, normalPreview: $normalPrev, saveTriggered: $saveTriggered)
    }
}
