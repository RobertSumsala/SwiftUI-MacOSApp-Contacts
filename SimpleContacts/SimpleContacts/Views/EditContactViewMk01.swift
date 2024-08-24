//
//  EditContactView.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 23/07/2024.
//

import SwiftUI

struct EditContactViewMk01: View {

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
                    onCanceled()
                }
                Spacer()
                Button("Done"){
                    editContactViewModel.number = editContactViewModel.formatNumber(number: editContactViewModel.number)
                    editContactViewModel.nameBeforeEdit = editContactViewModel.name
                    editContactViewModel.numberBeforeEdit = editContactViewModel.number
                    editContactViewModel.emailBeforeEdit = editContactViewModel.email
                    
                    onDone()
                }
            }.padding()
        }
        .padding()
        .frame(width: 400)
    }
}

#Preview {
    EditContactViewMk01(editContactVM: EditContactViewModel(contactVM: ContactViewModel(c: Contact())), onDone: {}, onCanceled: {})
}
