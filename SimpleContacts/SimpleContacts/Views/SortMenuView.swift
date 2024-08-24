//
//  SortMenuView.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 25/07/2024.
//

import SwiftUI

struct SortMenuView: View {
    
    var onAscending: () -> Void
    var onDescending: () -> Void
    
    @State var onAscendingPicked: Bool = true
    
    init(onAscending: @escaping () -> Void, onDescending: @escaping () -> Void) {
        self.onAscending = onAscending
        self.onDescending = onDescending
    }
    
    var body: some View {
        Menu(onAscendingPicked ? "Sort By A-Z" : "Sort By Z-A") {
            Button("Name (Ascending)") {
                onAscendingPicked = true
                onAscending()
            }
            Button("Name (Descending)") {
                onAscendingPicked = false
                onDescending()
            }
        }.frame(width:110)
            .padding()
    }
}

#Preview {
    SortMenuView(onAscending: {}, onDescending: {})
}
