//
//  AsyncImageView.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/10/25.
//

import SwiftUI

struct AsyncImageView: View {
    let url: URL?
    
    @State private var image: Image?
    @State private var isLoading: Bool = false

    var body: some View {
        ZStack {
            Color.gray
            
            Group {
                if let image {
                    image
                        .resizable()
                        .scaledToFill()
                } else if isLoading {
                    ProgressView()
                        .padding()
                } else {
                    PlaceholderImageView()
                }
            }
            .task {
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
