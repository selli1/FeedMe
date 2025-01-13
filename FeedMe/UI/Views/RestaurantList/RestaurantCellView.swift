//
//  RestaurantCellView.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/9/25.
//

import SwiftUI
import Foundation
struct RestaurantCellView: View {
    let restaurant: Business
    
    // Reusable cell view for displaying restaurant info
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                // Adding title view
                Text(restaurant.name)
                    .foregroundStyle(Color.secondary)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .padding(.bottom, 12)
                // Adding image view
                HStack(alignment: .top, spacing: 0) {
                    AsyncImageView(url: URL(string: restaurant.imageURL ?? ""))
                        .frame(width: 100, height: 75)
                        .padding(.trailing, 16)
                        .clipped()
                    // Adding detail text
                    VStack(alignment: .leading, spacing: 6) {
                        if let distance = restaurant.distance {
                            DistanceView(distance: distance)
                        }
                        if let rating = restaurant.rating, let reviewCount = restaurant.reviewCount {
                            RatingView(rating: rating, reviewCount: reviewCount)
                        }
                        PoweredByYelpView()
                    }
                    Spacer()
                }
            }
            .padding(16)
            .background(ThickMaterial())
            Divider()
                .foregroundStyle(Color.clear)
                .frame(height: 1.0)
        }
    }
}
