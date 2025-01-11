//
//  RatingView.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/9/25.
//

import SwiftUI

// View to display rating text
struct RatingView: View {
    let rating: Double
    let reviewCount: Int
    var textColor: Color = .primary
    
    var body: some View {
        HStack() {
            Text("\(rating, specifier: "%.1f")")
                .foregroundStyle(textColor)
                .fontWeight(.semibold)
            Text("(\(reviewCount) reviews)")
                .foregroundStyle(textColor)
        }
    }
}
