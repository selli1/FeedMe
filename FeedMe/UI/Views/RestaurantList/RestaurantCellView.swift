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
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                Text(restaurant.name)
                    .foregroundStyle(Color.primary)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .padding(.bottom, 12)
                
                HStack(alignment: .top, spacing: 0) {
                    AsyncImageView(url: URL(string: restaurant.imageURL ?? ""))
                        .frame(width: 100, height: 75)
                        .padding(.trailing, 16)
                        .clipped()
                    
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
            .background(ThinMaterial())
            Divider()
                .foregroundStyle(Color.clear)
                .frame(height: 1.0)
        }
    }
}
