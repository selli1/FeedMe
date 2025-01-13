//
//  ListPlaceholderView.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/12/25.
//

import SwiftUI

// Screen to show when we have no restaraunt results
struct ListPlaceholderView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "fork.knife.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
                .foregroundStyle(ThickMaterial())
                .padding()
            Spacer()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
