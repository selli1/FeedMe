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
                    Group {
                        if let imageURL = restaurant.imageURL {
                            AsyncImage(url: URL(string: imageURL)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 75)
                                    .clipped()
                            } placeholder: {
                                PlaceholderImageView()
                            }
                        } else {
                            PlaceholderImageView()
                        }
                    }
                    .frame(width: 100, height: 75)
                    .padding(.trailing, 16)
                    
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
            .background(.regularMaterial.blendMode(.luminosity))
            Divider()
                .foregroundStyle(Color.clear)
                .frame(height: 1.0)
        }
    }
}
