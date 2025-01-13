//
//  RestaurantDetailView.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/9/25.
//

import SwiftUI

struct RestaurantDetailView: View {
    let restaurant: Business
    
    // Variables for scrollview state
    @State private var scrollOffset: CGFloat = 0
    @State private var emptySpace: CGFloat = 0
    
    var body: some View {
        
        // Needed for calculating stretchy header
        let headerHeight: CGFloat = 300
        let overlapHeight: CGFloat = 20
        
        ZStack(alignment: .top) {
            // Adding image view and making it sticky / stretchy
            AsyncImageView(url: URL(string: restaurant.imageURL ?? ""))
                .frame(maxWidth: UIScreen.main.bounds.width)
                .frame(height: headerHeight + overlapHeight + max(0, -scrollOffset))
                .clipped()
                .transformEffect(.init(translationX: 0, y: -(max(0, scrollOffset))))
                // Adding header detail view over top of image view
                .overlay {
                    DetailHeaderView(restaurant: restaurant)
                        .padding(.bottom, overlapHeight)
                }

            ScrollView {
                // Spacer to push scrollview content below sticky header
                Spacer()
                    .frame(height: headerHeight)
                VStack(spacing: 0) {
                    DetailListView(restaurant: restaurant)
                    // Placeholder cell to take up empty bottom space
                    Color.clear.overlay(ThickMaterial())
                        .frame(height: emptySpace)
                }
                .background(CustomGradient().overlay(.thinMaterial))
            }
            // Observing scrollview geometry for managing sticky header and placeholder cell
            .onScrollGeometryChange(for: CGFloat.self, of: { geo in
                return geo.contentOffset.y + geo.contentInsets.top
            }, action: { new, old in
                scrollOffset = new
            })
            .onScrollGeometryChange(for: CGFloat.self, of: { geo in
                return geo.containerSize.height - geo.contentSize.height
            }, action: { new, old in
                emptySpace = new >= 0 ? new : 0
                print(new)
            })
        }
        .background(CustomGradient().overlay(ThickMaterial()))
        .ignoresSafeArea()
    }
}
