//
//  SectionHeader.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/12/25.
//

import SwiftUI

// Reuasble header view for use within various lists
struct SectionHeader: View {
    let labelText: LocalizedStringResource

    var body: some View {
        VStack(spacing: 0) {
            Text(labelText)
                .fontWeight(.bold)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
                .foregroundStyle(Color.clear)
                .frame(height: 1.0)
        }
    }
}
