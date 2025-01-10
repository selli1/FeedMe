//
//  DistanceView.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/9/25.
//

import SwiftUI

struct DistanceView: View {
    
    // Distance in meters
    let distance: Double
    
    var body: some View {
        let miles = Measurement(value: distance, unit: UnitLength.meters).converted(to: UnitLength.miles)
        Text("\(miles.value, specifier: "%.2f") mi")
            .foregroundStyle(Color.primary)
    }
}
