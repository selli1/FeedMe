//
//  Business.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/6/25.
//

import Foundation

struct Business: Codable, Identifiable, Hashable {
    let id: String
    let alias: String
    let name: String
    let imageURL: String?
    let isClosed: Bool?
    let url: String?
    let reviewCount: Int?
    let categories: [Category]?
    let rating: Double?
    let coordinates: Coordinates
    let transactions: [String]?
    let price: String?
    let location: Location
    let phone: String
    let displayPhone: String
    let distance: Double?
    let businessHours: [BusinessHours]?
    let attributes: Attributes?
    
    enum CodingKeys: String, CodingKey {
        case id, alias, name
        case imageURL = "image_url"
        case isClosed = "is_closed"
        case url
        case reviewCount = "review_count"
        case categories, rating, coordinates, transactions, price, location, phone
        case displayPhone = "display_phone"
        case distance
        case businessHours = "business_hours"
        case attributes
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Business, rhs: Business) -> Bool {
        return lhs.id == rhs.id
    }
}
