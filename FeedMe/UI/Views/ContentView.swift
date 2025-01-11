//
//  ContentView.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/6/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var restaurantsViewModel: RestaurantsViewModel = RestaurantsViewModel()
    @State var router: Router = Router()
    @State var locationManager: LocationManager = LocationManager()
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
    var body: some View {
        NavigationStack(path: $router.listTabNavigationPath) {
            RestaurantListView()
        }
        .accentColor(.white)
        .environment(router)
        .environment(restaurantsViewModel)
        .environment(locationManager)
        .onAppear() {
            locationManager.obtainUserLocation()
        }
        .onChange(of: locationManager.location?.latitude) {
            guard let latitude = locationManager.location?.latitude,
                  let longitude = locationManager.location?.longitude else { return }
            let location = Coordinates(latitude: latitude, longitude: longitude)
            Task {
                await restaurantsViewModel.fetchRestaurants(location)
            }
        }
    }
}

#Preview {
    ContentView()
}
