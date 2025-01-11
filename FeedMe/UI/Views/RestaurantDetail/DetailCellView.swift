//
//  DetailCellView.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/9/25.
//

import SwiftUI

struct DetailCellView: View {
    let title: LocalizedStringResource
    let values: [String]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(title)
                        .fontWeight(.bold)
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
            .background(ThinMaterial())
        }
        Divider()
            .foregroundStyle(Color.clear)
            .frame(height: 1.0)
    }
}
