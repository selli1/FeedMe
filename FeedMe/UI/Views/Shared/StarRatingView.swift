//
//  StarsRatingView.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/9/25.
//

import SwiftUI

// View for displaying the correct Yelp star rating image
struct StarRatingView: View {
    let rating: Double
    
    var body: some View {
        // Round number to nearest 0.5 to construct the proper image name
        let roundedNumberString = String(rating.round(to: 0.5))
        Image("ReviewStars\(roundedNumberString)")
    }
}
