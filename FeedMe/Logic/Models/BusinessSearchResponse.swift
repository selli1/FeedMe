//
//  BusinessSearchResponse.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/6/25.
//

struct BusinessSearchResponse: Codable {
    let businesses: [Business]
    let total: Int
    let region: Region
}
