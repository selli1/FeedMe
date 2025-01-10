//
//  DoubleExtension.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/10/25.
//

import Foundation

extension Double {
    func round(to nearest: Double) -> Double {
        let n = 1 / nearest
        let numberToRound = self * n
        return numberToRound.rounded() / n
    }
}
