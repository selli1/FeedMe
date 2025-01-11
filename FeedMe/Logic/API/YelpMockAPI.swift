//
//  YelpMockAPI.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/6/25.
//

import Foundation

// Mock API class used to parse and return objects from local json for testing purposes
class YelpMockAPI: YelpDataProvider {

    let stubFileName: String
    
    // initialize with name of the file
    init(stubFileName: String) {
        self.stubFileName = stubFileName
    }
    
    private let decoder = Decoder()

    // Implementing the required searchBusiness function from the YelpDataProvider protocol
    func searchBusinesses(_ location: Coordinates) async throws -> BusinessSearchResponse {
        // Try to get json file for supplied file name
        guard let url = Bundle.main.url(forResource: stubFileName, withExtension: "json") else { throw URLError(.fileDoesNotExist) }
        let data = try Data(contentsOf: url)
        // Attempt to parse and return BusinessSearchResponse object from file
        return try decoder.decode(BusinessSearchResponse.self, from: data)
    }
}
