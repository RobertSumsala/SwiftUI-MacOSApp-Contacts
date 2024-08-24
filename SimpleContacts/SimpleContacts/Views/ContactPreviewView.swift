//
//  ContactPreviewView.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 28/07/2024.
//

import SwiftUI

struct ContactPreviewView: View {
    
    var contact: ContactViewModel
    
    
    
    init(c: ContactViewModel){
        self.contact = c
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Image(nsImage: contact.photo)
                .resizable()
                .scaledToFill()
                .frame(width: 140, height: 140)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .padding()
            
            HStack{
                Text("Name: ")
                    .bold()
                Text(contact.name)
            }.padding(.vertical, 2)
            HStack{
                Text("Number: ")
                    .bold()
                Text(contact.number)
            }.padding(.vertical, 2)
            HStack{
                Text("Email: ")
                    .bold()
                Text(contact.email == "" ? "N/A" : contact.email)
            }.padding(.vertical, 2)
            
            
            Image(systemName: contact.isFavourited ? Constants.Icons.starFill : Constants.Icons.star)
                .font(.system(size: 20))
                .padding()
        }
        
        
        
    }
}

struct ContactPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        return ContactPreviewView(c: ContactViewModel(c: Contact()))
    }
}
