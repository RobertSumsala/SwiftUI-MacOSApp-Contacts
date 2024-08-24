//
//  PhotoDropAreaView.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 31/07/2024.
//

import SwiftUI
import UniformTypeIdentifiers

struct PhotoDropAreaView: View {
    @Binding var photo: NSImage
    @State var isDropActive = false
    
    init(photo: Binding<NSImage>) {
        self._photo = photo
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Drag and drop your photo here")
                .padding()
                .opacity(0.5)
            Image(systemName: Constants.Icons.plusSquareOnSquare)
                .font(.title)
                .opacity(0.3)
        }
        .frame(width: 350, height: 250)
        .onDrop(of: [UTType.fileURL], isTargeted: $isDropActive) { providers in
            handleDrop(providers: providers)
        }
    }
    
    private func handleDrop(providers: [NSItemProvider]) -> Bool {
            for provider in providers {
                if provider.hasItemConformingToTypeIdentifier(UTType.fileURL.identifier) {
                    provider.loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) { item, error in
                        guard let data = item as? Data else { return }
                        if let url = URL(dataRepresentation: data, relativeTo: nil), let image = NSImage(contentsOf: url) {
                            DispatchQueue.main.async {
                                self.photo = image
                            }
                        }
                    }
                    return true
                }
            }
            return false
        }
        
    
}

//
//struct PhotoDropAreaView_Previews: PreviewProvider {
//    @State var img: NSImage = NSImage(size: NSSize(width: 100, height: 100))
//    static var previews: some View {
//        return PhotoDropAreaView(photo: $img)
//    }
//}
