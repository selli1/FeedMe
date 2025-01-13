//
//  RestaurantTests.swift
//  FeedMeTests
//
//  Created by Steven Elliott on 1/10/25.
//

import Testing
@testable import FeedMe

@MainActor
@Suite(.serialized)
struct RestaurantTests {
    
    var viewModel = RestaurantsViewModel(api: YelpMockAPI(stubFileName: "BusinessSearchMock"))
    
    let location = Coordinates(latitude: 0.0, longitude: 0.0)
    
    @Test func getRestaurants() async throws {
        // given
        // when
        await viewModel.fetchRestaurants(location)
        // then
        #expect(viewModel.searchResponse?.businesses.count == 50)
    }
    
    @Test func closeRestaurants() async throws {
        // given
        await viewModel.fetchRestaurants(location)
        let expectedFirstObjectId = "0n0C5zCqhjG2XDSOhlQ4Vg"
        let expectedLastObjectId = "dfL1KYHtcs6YaFVx-nZTdQ"
        // when
        let firstRestaurant = viewModel.closeRestaurants().first
        let lastRestaurant = viewModel.closeRestaurants().last
        //then
        #expect(firstRestaurant?.id == expectedFirstObjectId)
        #expect(lastRestaurant?.id == expectedLastObjectId)
    }
    
    @Test func topRestaurants() async throws {
        // given
        await viewModel.fetchRestaurants(location)
        let expectedFirstObjectId = "0n0C5zCqhjG2XDSOhlQ4Vg"
        let expectedLastObjectId = "QW3anlt1nJ9aNkdQAV-Ifw"
        // when
        let firstRestaurant = viewModel.topRestaurants().first
        let lastRestaurant = viewModel.topRestaurants().last
        //then
        #expect(firstRestaurant?.id == expectedFirstObjectId)
        #expect(lastRestaurant?.id == expectedLastObjectId)
    }
}
