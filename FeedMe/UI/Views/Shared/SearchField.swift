//
//  SearchField.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/12/25.
//

import SwiftUI

// Reausable search view styled with a placeholder image
struct SearchField: View {
    @Binding var text: String
    var isFocused: FocusState<Bool>.Binding
    var placeHolderText: LocalizedStringResource = "Search ..."
    let onReturn: () -> Void
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.separator)
            TextField(String(localized: placeHolderText), text: $text)
                .foregroundColor(.primary)
                .accentColor(.primary)
                .focused(isFocused)
                .onSubmit {
                    onReturn()
                }
                .onChange(of: isFocused.wrappedValue) {
                    if isFocused.wrappedValue == true {
                        text = ""
                    }
                }
        }
        .padding(6)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.separator, lineWidth: 1)
        )
    }
}
