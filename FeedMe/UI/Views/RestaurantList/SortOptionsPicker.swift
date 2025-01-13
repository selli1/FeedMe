//
//  SortOptionsPicker.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/10/25.
//

import SwiftUI

// Sort options enum for picker with localizable strings
enum SortOption: LocalizedStringResource, CaseIterable, Identifiable {
    case rating = "Top Rated"
    case distance = "Closest"
    
    var id: SortOption { self }
    
    var titleText: LocalizedStringResource {
        switch self {
        case .rating:
            return "Top Spots"
        case .distance:
            return "Close Spots"
        }
    }
}

// Picker for restaurant sorting criteria
struct SortOptionsPicker: View {
    @Binding var selectedCategory: SortOption
    var body: some View {
        Picker("", selection: $selectedCategory) {
            ForEach(SortOption.allCases) { category in
                 Text(category.rawValue).tag(category)
           }
        }
        .pickerStyle(.segmented)
        .accessibilityLabel("Segmented picker control")
    }
}
