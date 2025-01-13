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
        .environment(locationManager)
    }
}

#Preview {
    ContentView()
}
