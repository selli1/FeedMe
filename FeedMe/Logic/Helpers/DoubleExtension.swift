//
//  DoubleExtension.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/10/25.
//

import Foundation

extension Double {
    // Function to round to a nearest supplied value
    func round(to nearest: Double) -> Double {
        let n = 1 / nearest
        let numberToRound = self * n
        return numberToRound.rounded() / n
    }
}
