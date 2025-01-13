//
//  YelpDataProvider.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/6/25.
//

protocol YelpDataProvider {
    func searchBusinesses(_ coordinates: Coordinates) async throws -> BusinessSearchResponse
    func searchBusinesses(_ locationName: String) async throws -> BusinessSearchResponse
}
