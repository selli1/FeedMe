//
//  RestaurantsViewModel.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/7/25.
//

import Foundation

// Main ViewModel responsible for restaurant related data and functionality
@MainActor
@Observable
class RestaurantsViewModel {
    private let api: YelpDataProvider
    
    // Container object for business (restaurant) data
    var searchResponse: BusinessSearchResponse?
    var isLoadingRestaurants: Bool = false
    var error: Error?
    
    // Initializer to allow for dependency injection of a data provider
    init(api: YelpDataProvider = YelpAPI()) {
        self.api = api
    }
    // Request business data from API and store to searchResponse object
    func fetchRestaurants(_ coordinates: Coordinates) async {
        self.error = nil
        self.isLoadingRestaurants = true
        defer { self.isLoadingRestaurants = false }
        do {
            searchResponse = try await api.searchBusinesses(coordinates)
        } catch {
            self.error = error
        }
    }
    
    // Request business data from API and store to searchResponse object
    func fetchRestaurants(_ location: String) async {
        self.error = nil
        self.isLoadingRestaurants = true
        defer { self.isLoadingRestaurants = false }
        do {
            searchResponse = try await api.searchBusinesses(location)
        } catch {
            self.error = error
        }
    }
    
    // Function for sorting restaurants based on highest reviews
    func topRestaurants() -> [Business] {
        guard let businesses = searchResponse?.businesses else { return [] }
        return businesses.sorted {
            if $0.rating != $1.rating {
                return $0.rating ?? 0 > $1.rating ?? 0
            } else {
                return $0.distance ?? 0 < $1.distance ?? 0
            }
        }
    }
    
    // Function for sorting restaurants based on closest to you
    func closeRestaurants() -> [Business] {
        guard let businesses = searchResponse?.businesses else { return [] }
        return businesses.sorted {
            if $0.distance != $1.distance {
                return $0.distance ?? 0 < $1.distance ?? 0
            } else {
                return $0.rating ?? 0 > $1.rating ?? 0
            }
        }
    }
}
