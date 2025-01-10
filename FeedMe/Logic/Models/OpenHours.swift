//
//  OpenHours.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/7/25.
//

struct OpenHours: Codable {
    let isOvernight: Bool
    let start: String
    let end: String
    let day: Int
    
    enum CodingKeys: String, CodingKey {
        case isOvernight = "is_overnight"
        case start, end, day
    }
}
