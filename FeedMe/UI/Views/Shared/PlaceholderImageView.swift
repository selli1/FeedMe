//
//  PlaceholderImageView.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/9/25.
//

import SwiftUI

// Image to diplay when downloaded image does not exist
struct PlaceholderImageView: View {
    var body: some View {
        Image(systemName: "photo.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .tint(.white)
            .padding()
            .background(Color.gray)
    }
}
