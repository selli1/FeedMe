//
//  DetailCellView.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/9/25.
//

import SwiftUI

// Reusable cell for displaying business info
struct DetailCellView: View {
    let title: LocalizedStringResource
    let values: [String]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    // Displaying title
                    Text(title)
                        .foregroundStyle(Color.secondary)
                        .fontWeight(.bold)
                    // Displaying multiline values
                    VStack(alignment: .leading) {
                        ForEach(values, id: \.self) { value in
                            Text(value)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 30)
                
                Spacer()
            }
            .background(ThickMaterial())
        }
        Divider()
            .foregroundStyle(Color.clear)
            .frame(height: 1.0)
    }
}
