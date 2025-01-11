//
//  CustomGradient.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/9/25.
//

import SwiftUI

// Convenience definitions for reused shape styles

struct CustomGradient: ShapeStyle, View {
    func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        LinearGradient(gradient: Gradient(colors: [.pink, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

struct ThinMaterial: ShapeStyle, View {
    func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        .thinMaterial.blendMode(.luminosity)
    }
}

struct RegularMaterial: ShapeStyle, View {
    func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        .regularMaterial.blendMode(.luminosity)
    }
}

struct ThickMaterial: ShapeStyle, View {
    func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        .thickMaterial.blendMode(.luminosity)
    }
}
