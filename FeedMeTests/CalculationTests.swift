//
//  CalculationTests.swift
//  FeedMeTests
//
//  Created by Steven Elliott on 1/6/25.
//

import Testing
@testable import FeedMe

struct CalculationTests {
    @Test(arguments: zip([0.4, 0.2, 4.1, 4.25], [0.5, 0.0, 4.0, 4.5]))
    func rounding(input: Double, output: Double) {
        // given
        let rating = input
        // when
        let roundedRating = rating.round(to: 0.5)
        // then
        #expect(roundedRating == output)
    }
}
