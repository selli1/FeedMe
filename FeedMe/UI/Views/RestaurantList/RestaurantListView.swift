//
//  RestaurantListView.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/9/25.
//

import SwiftUI

struct RestaurantListView: View {
    @Environment(Router.self) var router
    @Environment(RestaurantsViewModel.self) var restaurantsViewModel
            
    @State private var sortSelection: SortOption = .rating
    
    var body: some View {
        VStack(spacing: 0) {
            let restaurants = sortSelection == .rating ?
            restaurantsViewModel.topRestaurants() :
            restaurantsViewModel.closeRestaurants()
            
            VStack(spacing: 0) {
                SortOptionsPicker(selectedCategory: $sortSelection)
                .padding()
                .background(.ultraThickMaterial.blendMode(.luminosity))
                
                ScrollView {
                    LazyVStack(spacing: 0) {
                        
                        ForEach(restaurants) { restaurant in
                            NavigationLink(value: restaurant) {
                                RestaurantCellView(restaurant: restaurant)
                            }
                        }
                    }
                }
                .overlay {
                    if restaurants.isEmpty {
                        Color.clear
                            .overlay(.regularMaterial.blendMode(.luminosity))
                    }
                }
            }
        }
        .navigationDestination(for: Business.self) { business in
            RestaurantDetailView(restaurant: business)
        }
        .navigationTitle(String(localized: sortSelection.titleText))
        .toolbarBackground(
            .ultraThickMaterial.blendMode(.luminosity),
            for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .background(CustomGradient())
    }
}
