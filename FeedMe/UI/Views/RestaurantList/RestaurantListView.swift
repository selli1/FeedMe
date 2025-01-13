//
//  RestaurantListView.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/9/25.
//

import SwiftUI
import CoreLocation

struct RestaurantListView: View {
    
    // Getting access to observed environment objects
    @Environment(Router.self) var router
    @Environment(RestaurantsViewModel.self) var restaurantsViewModel
    @Environment(LocationManager.self) var locationManager
    
    // Variable to hold state of the sort option picker
    @State private var sortSelection: SortOption = .rating
    
    // Variables to hold SearchView state
    @State private var locationText: String = "Current Location"
    @FocusState private var isSearchFieldFocused: Bool
    
    // Variables to hold state for various alerts
    @State private var showingLocationAlert = false
    @State private var showingNetworkingAlert = false

    var body: some View {
        ZStack {
            //Setting Background
            CustomGradient().overlay(.thinMaterial)
                .ignoresSafeArea()
            
            // Getting restaurants sorted based on the sortSelection
            let restaurants = sortSelection == .rating ?
            restaurantsViewModel.topRestaurants() :
            restaurantsViewModel.closeRestaurants()
            
            VStack(spacing: 0) {
                // Adding the searchfield
                SearchField(text: $locationText, isFocused: $isSearchFieldFocused, placeHolderText: "Search for location" ) {
                    // Fetching results on submit from the textfield
                    Task {
                        if !locationText.isEmpty {
                            await restaurantsViewModel.fetchRestaurants(locationText)
                        }
                    }
                }
                .padding(.top)
                .padding(.horizontal)
                .background(.ultraThickMaterial)
                .accessibilityLabel("Search bar")
                
                // Adding sort options picker
                SortOptionsPicker(selectedCategory: $sortSelection)
                .padding()
                .background(.ultraThickMaterial)
                
                Divider()
                    .foregroundStyle(Color.clear)
                    .frame(height: 1.0)
                ZStack {
                    
                    if restaurants.isEmpty {
                        ListPlaceholderView()
                    } else {
                        // Adding main list content
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 0) {
                                // Populating restaurant cells
                                Section {
                                    ForEach(restaurants) { restaurant in
                                        NavigationLink(value: restaurant) {
                                            RestaurantCellView(restaurant: restaurant)
                                        }
                                    }
                                } header: {
                                    SectionHeader(labelText: "Restaurants near me")
                                }
                            }
                        }
                        .background(CustomGradient().overlay(.thinMaterial))
                        .ignoresSafeArea()
                    }

                    if restaurantsViewModel.isLoadingRestaurants {
                        LoadingView()
                    }
                }
            }
            // Clear view used for keyboard dismissal
            if isSearchFieldFocused {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isSearchFieldFocused = false
                    }
            }
        }
        // Handling navigation to detail view
        .navigationDestination(for: Business.self) { business in
            RestaurantDetailView(restaurant: business)
        }
        // Configuring navigation properties
        .navigationTitle(String(localized: sortSelection.titleText))
        .toolbarBackground(ThickMaterial(), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        // Observing for changes in user location
        .onChange(of: locationManager.location?.latitude) {
            fetchRestaurants()
        }
        // Observing for LocationManager errors
        .onChange(of: locationManager.error?.localizedDescription) {
            if locationManager.error != nil {
                showingLocationAlert = true
            }
        }
        // Oberving for RestaurantsViewModel errors
        .onChange(of: restaurantsViewModel.error?.localizedDescription) {
            if restaurantsViewModel.error != nil {
                showingNetworkingAlert = true
            }
        }
        // Presenting network error alert
        .alert(isPresented: $showingNetworkingAlert) {
            alertForNetworkingError(restaurantsViewModel.error)
        }
        // Presenting location manager alert
        .alert("Location Access Failed", isPresented: $showingLocationAlert) {
            Button("OK", role: .cancel) {
                locationManager.error = nil
            }
            Button("Search") {
                locationManager.error = nil
                isSearchFieldFocused = true
            }
        } message: {
            Text("Please check your settings to enable location access.")
        }
    }
    
    // Fetching restaurants if we have a location
    private func fetchRestaurants() {
        guard let latitude = locationManager.location?.latitude,
              let longitude = locationManager.location?.longitude else { return }
        let location = Coordinates(latitude: latitude, longitude: longitude)
        Task {
            await restaurantsViewModel.fetchRestaurants(location)
        }
    }
    
    // Configuring Alert based on type of network error
    private func alertForNetworkingError(_ error: Error?) -> Alert {
        var title: Text = Text("Restaurant Lookup Failed")
        var message: Text? = nil

        let primaryButton: Alert.Button = Alert.Button.cancel(Text("OK")) {
            restaurantsViewModel.error = nil
        }
        
        if let serverError = error as? ServerError {
            switch serverError {
            case .authorizationError, .unauthorized, .payloadTooLarge:
                // These should not occur in this context so break
                break
            case .invalidRequest, .resourceNotFound:
                title = Text("No Results Found")
            case .rateLimited:
                message = Text("You have reached your maximum number of requests for today. Please try again tomorrow.")
                print("rateLimited")
            case .internalServerError, .serviceUnavailable, .unknownError(code: _):
                message = Text("We could not complete your request right now. Please try again later.")
            }
        } else {
            message = Text("Please check your internet connection and try again")
        }
        return Alert(title: title,
                     message: message,
                     dismissButton: primaryButton)
    }
}
