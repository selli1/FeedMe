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
        #expect(viewModel.searchResponse?.businesses.count == 1)
    }
    
    @Test func closeRestaurants() async throws {
        // given
        await viewModel.fetchRestaurants(location)
        let expectedName = "ts2WASctpBwC-0lFrDdlVQ"
        // when
        let restaurant = viewModel.closeRestaurants().first
        //then
        #expect(restaurant?.id == expectedName)
    }
    
    @Test func topRestaurants() async throws {
        // given
        await viewModel.fetchRestaurants(location)
        let expectedId = "ts2WASctpBwC-0lFrDdlVQ"
        // when
        let restaurant = viewModel.topRestaurants().first
        //then
        #expect(restaurant?.id == expectedId)
    }
}
