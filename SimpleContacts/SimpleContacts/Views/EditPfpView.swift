//
//  EditPfpView.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 30/07/2024.
//

import SwiftUI

struct EditPfpView: View {
    @ObservedObject var editContactViewModel: EditContactViewModel
    
    @State var uploadPhotoPresented: Bool = false
    
    init(editContactViewModel: EditContactViewModel) {
        self.editContactViewModel = editContactViewModel
    }
    
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                Image(systemName: Constants.Icons.xCircle)
                    .offset(CGSize(width: -70.0, height: -70.0))
                    .font(.title)
                    .onTapGesture {
                        editContactViewModel.photo = NSImage(systemSymbolName: Constants.Icons.personCircleFill, accessibilityDescription: nil)!
                        editContactViewModel.wasEdited = true
                    }
                Image(nsImage: editContactViewModel.photo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 140, height: 140)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .padding()
            }
            Button("Change Cover Photo"){
                editContactViewModel.wasEdited = true
                uploadPhotoPresented = true
            }
        }.sheet(isPresented: $uploadPhotoPresented, content: {
            UploadPhotosView(editContactVM: editContactViewModel, isPresented: $uploadPhotoPresented)
        })
    }
}

struct EditPfpView_Previews: PreviewProvider {
    static var previews: some View {
        return EditPfpView(editContactViewModel: EditContactViewModel(contactVM: ContactViewModel(c: Contact())))
    }
}
