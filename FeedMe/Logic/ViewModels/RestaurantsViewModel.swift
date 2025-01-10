//
//  RestaurantsViewModel.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/7/25.
//

import Foundation

@MainActor
@Observable
class RestaurantsViewModel {
    private let api: YelpDataProvider
    
    var searchResponse: BusinessSearchResponse?
    
    init(api: YelpDataProvider = YelpAPI()) {
        self.api = api
    }
    
    func fetchRestaurants(_ location: Coordinates) async {
        do {
            searchResponse = try await api.searchBusinesses(location)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func topRestaurants() -> [Business] {
        guard let businesses = searchResponse?.businesses else { return [] }
        return businesses.sorted(by: {$0.rating ?? 0 > $1.rating ?? 0})
    }
    
    func closeRestaurants() -> [Business] {
        guard let businesses = searchResponse?.businesses else { return [] }
        return businesses.sorted(by: {$0.distance ?? 0 < $1.distance ?? 0})
    }
}
