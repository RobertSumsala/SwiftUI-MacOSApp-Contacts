//
//  AddNewContactView.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 21/07/2024.
//

import SwiftUI

struct AddNewContactView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var vm: AddNewContactViewModel
    
    @State var missingArgument: Bool = false
    
    init(vm: AddNewContactViewModel) {
        self.vm = vm
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            if missingArgument {
                Text("Name and Number has to be filled in")
                    .foregroundColor(.red)
            }
            HStack {
                Text("Name: ")
                    .padding(.trailing, 13)
                Spacer()
                TextField("", text: $vm.name)
            }
            HStack {
                Text("Number: ")
                Spacer()
                TextField("", text: $vm.number)
            }
            HStack {
                Text("E-mail: ")
                    .padding(.trailing, 10)
                Spacer()
                TextField("Optional", text: $vm.email)
            }
            HStack (alignment: .center) {
                Button("Cancel"){
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Button("Add"){
                    if vm.number.isEmpty || vm.name.isEmpty {
                        missingArgument = true
                    } else {
                        missingArgument = false
                        vm.save()
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                }
            }.padding()
        }
        .padding()
        .frame(width: 400)
    }
}

struct AddNewContactView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistentContainer.viewContext
        return AddNewContactView(vm: AddNewContactViewModel(context: viewContext, contactsVM: ContactsViewModel(context: viewContext)))
    }
}
