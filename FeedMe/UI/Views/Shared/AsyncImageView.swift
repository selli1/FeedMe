//
//  AsyncImageView.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/10/25.
//

import SwiftUI

// View responsible for fetching diplaying network images
struct AsyncImageView: View {
    let url: URL?
    
    @State private var image: Image?
    @State private var isLoading: Bool = false

    var body: some View {
        ZStack {
            // Setting background
            Color.gray
            
            Group {
                // Display image if it exists
                if let image {
                    image
                        .resizable()
                        .scaledToFill()
                    // Show loading if loading
                } else if isLoading {
                    ProgressView()
                        .padding()
                    // Else show progress view
                } else {
                    PlaceholderImageView()
                }
            }
            .task {
                // download the image
                guard let url else { return }
                defer { isLoading = false }
                isLoading = true
                do {
                    if let uiImage = try await ImageCache.shared.getImage(url) {
                        self.image = Image(uiImage: uiImage)
                    }
                } catch {
                    print("Failed to load image: \(error)")
                }
            }
        }
    }
}
