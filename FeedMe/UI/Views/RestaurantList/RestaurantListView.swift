//
//  RestaurantListView.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/9/25.
//

import SwiftUI

struct RestaurantListView: View {
    
    // Getting access to observed environment objects
    @Environment(Router.self) var router
    @Environment(RestaurantsViewModel.self) var restaurantsViewModel
    
    // Variable to hold state of the sort option picker
    @State private var sortSelection: SortOption = .rating

    var body: some View {
        VStack(spacing: 0) {
            // Getting restaurants sorted based on the sortSelection
            let restaurants = sortSelection == .rating ?
            restaurantsViewModel.topRestaurants() :
            restaurantsViewModel.closeRestaurants()
            
            VStack(spacing: 0) {
                // Adding sort options picker
                SortOptionsPicker(selectedCategory: $sortSelection)
                .padding()
                .background(ThickMaterial())
                
                ScrollView {
                    LazyVStack(spacing: 0) {
                        // Populating restaurant cells
                        ForEach(restaurants) { restaurant in
                            NavigationLink(value: restaurant) {
                                RestaurantCellView(restaurant: restaurant)
                            }
                        }
                    }
                }
                .ignoresSafeArea()
            }
            .background(ThinMaterial())
        }
        .background(CustomGradient())
        // Handling navigation to detail view
        .navigationDestination(for: Business.self) { business in
            RestaurantDetailView(restaurant: business)
        }
        // Configuring navigation properties
        .navigationTitle(String(localized: sortSelection.titleText))
        .toolbarBackground(ThickMaterial(), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}
