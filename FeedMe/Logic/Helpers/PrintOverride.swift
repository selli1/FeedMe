//
//  PrintOverride.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/10/25.
//

// Print function shadowing used to prevent print statements frome executing in production code
public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
        let output = items.map { "\($0)" }.joined(separator: separator)
        Swift.print(output, terminator: terminator)
    #else
    #endif
}
