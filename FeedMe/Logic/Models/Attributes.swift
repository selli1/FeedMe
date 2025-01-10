//
//  Attributes.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/7/25.
//

struct Attributes: Codable {
    let businessTempClosed: Int?
    let menuURL: String?
    let open24Hours: Bool?
    let waitlistReservation: Bool?
    
    enum CodingKeys: String, CodingKey {
        case businessTempClosed = "business_temp_closed"
        case menuURL = "menu_url"
        case open24Hours = "open24_hours"
        case waitlistReservation = "waitlist_reservation"
    }
}
