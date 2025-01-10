//
//  YelpDataProvider.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/6/25.
//

protocol YelpDataProvider {
    func searchBusinesses(_ location: Coordinates) async throws -> BusinessSearchResponse
}
