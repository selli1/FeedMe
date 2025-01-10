//
//  BusinessHours.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/7/25.
//

import Foundation

struct BusinessHours: Codable {
    let open: [OpenHours]
    let hoursType: String
    let isOpenNow: Bool
    
    enum CodingKeys: String, CodingKey {
        case open
        case hoursType = "hours_type"
        case isOpenNow = "is_open_now"
    }
    
    var hoursDisplayString: String? {
        let today = Calendar.current.dateComponents([.weekday], from: Date()).weekday
        guard  let todayHours = open.first(where: {$0.day == today}),
               todayHours.start.count == 4,
               todayHours.end.count == 4 else { return nil }
        var start = todayHours.start
        start.insert(":", at: start.index(start.startIndex, offsetBy: 2))
        var end = todayHours.end
        end.insert(":", at: end.index(end.startIndex, offsetBy: 2))
        return "\(start) - \(end)"
    }
}
