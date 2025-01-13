//
//  PoweredByYelpView.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/9/25.
//

import SwiftUI

struct PoweredByYelpView: View {
    var body: some View {
        HStack {
            Text("powered by")
                .foregroundStyle(Color.primary)
            Image("YelpLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 20)
                .accessibilityLabel("Yelp")
        }
    }
}

