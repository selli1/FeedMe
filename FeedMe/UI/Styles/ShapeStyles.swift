//
//  CustomGradient.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/9/25.
//

import SwiftUI

struct CustomGradient: ShapeStyle, View {
    func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        LinearGradient(gradient: Gradient(colors: [.pink, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
