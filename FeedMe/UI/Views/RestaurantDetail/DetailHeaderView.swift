//
//  DetailHeaderView.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/9/25.
//

import SwiftUI

struct DetailHeaderView: View {
    let restaurant: Business
    
    var body: some View {
        ZStack {
            Group {
                if let imageUrl = restaurant.imageURL {
                    AsyncImage(url: URL(string: imageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 300)
                            .frame(maxWidth: UIScreen.main.bounds.width)
                            .clipped()
                    } placeholder: {
                        PlaceholderImageView()
                    }
                } else {
                    PlaceholderImageView()
                }
            }

            HStack {
                VStack(alignment: .leading) {
                    Spacer()
                    Text(restaurant.name)
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.bold)
                    if let rating = restaurant.rating, let reviewCount = restaurant.reviewCount {
                        HStack {
                            StarRatingView(rating: rating)

                            RatingView(rating: rating, reviewCount: reviewCount, textColor: Color.white)
                        }
                        PoweredByYelpView().colorScheme(.dark)
                    }
                }
                .shadow(color: Color.black, radius: 6, x: 0, y: 0)
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
                Spacer()
            }
            .background(Color.black.opacity(0.3))
        }
    }
}
