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
                .background(ThickMaterial())
                
                ScrollView {
                    LazyVStack(spacing: 0) {
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
        .navigationDestination(for: Business.self) { business in
            RestaurantDetailView(restaurant: business)
        }
        .navigationTitle(String(localized: sortSelection.titleText))
        .toolbarBackground(ThickMaterial(), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}
