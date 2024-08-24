//
//  EditContactView.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 30/07/2024.
//

import SwiftUI

struct EditContactView: View {

    @ObservedObject var editContactViewModel: EditContactViewModel
    
    var onDone: () -> Void
    var onCanceled: () -> Void
    
    init(editContactVM: EditContactViewModel, onDone: @escaping () -> Void, onCanceled: @escaping () -> Void) {
        self.editContactViewModel = editContactVM
        self.onDone = onDone
        self.onCanceled = onCanceled
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Name: ")
                    .padding(.trailing, 13)
                Spacer()
                TextField(editContactViewModel.name, text: $editContactViewModel.name)
            }
            HStack {
                Text("Number: ")
                Spacer()
                TextField(editContactViewModel.number, text: $editContactViewModel.number)
            }
            HStack {
                Text("E-mail: ")
                    .padding(.trailing, 10)
                Spacer()
                TextField(editContactViewModel.email, text: $editContactViewModel.email)
            }
            HStack (alignment: .center) {
                Button("Cancel"){
                    editContactViewModel.name = editContactViewModel.nameBeforeEdit
                    editContactViewModel.number = editContactViewModel.numberBeforeEdit
                    editContactViewModel.email = editContactViewModel.emailBeforeEdit
                    editContactViewModel.photo = editContactViewModel.photoBeforeEdit
                    
                    onCanceled()
                }
                Spacer()
                Button("Done"){
                    editContactViewModel.wasEdited = true
                    
                    editContactViewModel.numberBeforeEdit = editContactViewModel.formatNumber(number: editContactViewModel.number)
                    editContactViewModel.nameBeforeEdit = editContactViewModel.name
                    editContactViewModel.numberBeforeEdit = editContactViewModel.number
                    editContactViewModel.emailBeforeEdit = editContactViewModel.email
                    editContactViewModel.photoBeforeEdit = editContactViewModel.photo
                    
                    onDone()
                }
            }.padding()
        }
        .padding()
        .frame(width: 300)
    }
}

#Preview {
    EditContactView(editContactVM: EditContactViewModel(contactVM: ContactViewModel(c: Contact())), onDone: {}, onCanceled: {})
}
