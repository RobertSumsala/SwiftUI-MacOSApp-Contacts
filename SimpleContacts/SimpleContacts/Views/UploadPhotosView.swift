//
//  UploadPhotosView.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 31/07/2024.
//

import SwiftUI

struct UploadPhotosView: View {
    @ObservedObject var editContactVM: EditContactViewModel
    @Binding var isPresented: Bool
    
    init(editContactVM: EditContactViewModel, isPresented: Binding<Bool>) {
        self.editContactVM = editContactVM
        self._isPresented = isPresented
    }
    
    var body: some View {
        VStack {
            PhotoDropAreaView(photo: $editContactVM.photo)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(Color.secondary, width: 3)
                .padding()
            
            Button("Done") {
                editContactVM.wasEdited = true
                isPresented = false
            }
        }.padding()
    }
}


struct UploadPhotosView_Previews: PreviewProvider {
    @State static var isPresented: Bool = true
    static var previews: some View {
        return UploadPhotosView(editContactVM: EditContactViewModel(contactVM: ContactViewModel(c: Contact())), isPresented: $isPresented)
    }
}

