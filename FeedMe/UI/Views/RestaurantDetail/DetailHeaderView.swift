//
//  DetailHeaderView.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/9/25.
//

import SwiftUI

// Text container to go over top sticky image header
struct DetailHeaderView: View {
    let restaurant: Business
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Spacer()
                // Adding title
                Text(restaurant.name)
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                // Adding other details
                if let rating = restaurant.rating, let reviewCount = restaurant.reviewCount {
                    HStack {
                        StarRatingView(rating: rating)

                        RatingView(rating: rating, reviewCount: reviewCount, textColor: Color.white)
                    }
                    PoweredByYelpView().colorScheme(.dark)
                }
            }
            // Adding shadow to make text pop
            .shadow(color: Color.black, radius: 6, x: 0, y: 0)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            Spacer()
        }
        // Adding dark overlay to make text pop
        .background(Color.black.opacity(0.3))
    }
}
