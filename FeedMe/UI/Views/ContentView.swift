//
//  ContentView.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/6/25.
//

import SwiftUI

struct ContentView: View {
    
    // Instantiate observed objects to be shared with the environment
    @State var restaurantsViewModel: RestaurantsViewModel = RestaurantsViewModel()
    @State var router: Router = Router()
    @State var locationManager: LocationManager = LocationManager()
    
    @State private var showingLocationAlert = false
    @State private var showingNetworkingAlert = false
    
    init() {
        // Modifying navbar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
    var body: some View {
        // Creating the main NavigationStack with RestaurantListView at it's root
        NavigationStack(path: $router.listTabNavigationPath) {
            RestaurantListView()
        }
        .accentColor(.white)
        // Injecting observed classes in the environment
        .environment(router)
        .environment(restaurantsViewModel)
        // Attempt to get user location
        .onAppear() {
            locationManager.obtainUserLocation()
        }
        // Observing for changes in user location
        .onChange(of: locationManager.location?.latitude) {
            guard let latitude = locationManager.location?.latitude,
                  let longitude = locationManager.location?.longitude else { return }
            let location = Coordinates(latitude: latitude, longitude: longitude)
            // Fetching restaurants once we have a location
            Task {
                await restaurantsViewModel.fetchRestaurants(location)
            }
        }
        .onChange(of: locationManager.error?.localizedDescription) {
            if locationManager.error != nil {
                showingLocationAlert = true
            }
        }
        .onChange(of: restaurantsViewModel.error?.localizedDescription) {
            if restaurantsViewModel.error != nil {
                showingNetworkingAlert = true
            }
        }
        .alert("Location Access Failed", isPresented: $showingLocationAlert) {
            Button("OK", role: .cancel) {
                locationManager.error = nil
            }
        } message: {
            Text("Please check your settings enable location access.")
        }
        .alert("Network Call Failed", isPresented: $showingNetworkingAlert) {
            Button("OK", role: .cancel) {
                restaurantsViewModel.error = nil
            }
        } message: {
            Text("Please check your network access or try again later.")
        }
    }
}

#Preview {
    ContentView()
}
