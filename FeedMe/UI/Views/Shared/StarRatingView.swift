//
//  StarsRatingView.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/9/25.
//

import SwiftUI

struct StarRatingView: View {
    let rating: Double
    
    var body: some View {
        let roundedNumberString = String(rating.round(to: 0.5))
        Image("ReviewStars\(roundedNumberString)")
    }
}
