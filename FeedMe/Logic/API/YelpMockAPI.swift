//
//  YelpMockAPI.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/6/25.
//

import Foundation

class YelpMockAPI: YelpDataProvider {
    
    let stubFileName: String
    
    init(stubFileName: String) {
        self.stubFileName = stubFileName
    }
    
    private let decoder = Decoder()

    func searchBusinesses(_ location: Coordinates) async throws -> BusinessSearchResponse {
        guard let url = Bundle.main.url(forResource: stubFileName, withExtension: "json") else { throw URLError(.fileDoesNotExist) }
        let data = try Data(contentsOf: url)
        return try decoder.decode(BusinessSearchResponse.self, from: data)
    }
}
