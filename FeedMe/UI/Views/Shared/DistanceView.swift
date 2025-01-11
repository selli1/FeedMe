//
//  DistanceView.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/9/25.
//

import SwiftUI

// View to display distance of the business from you
struct DistanceView: View {
    
    // Distance in meters
    let distance: Double
    
    var body: some View {
        // Convert meters to miles
        let miles = Measurement(value: distance, unit: UnitLength.meters).converted(to: UnitLength.miles)
        Text("\(miles.value, specifier: "%.2f") mi")
            .foregroundStyle(Color.primary)
    }
}
