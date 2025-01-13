//
//  DetailListView.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/12/25.
//

import SwiftUI

struct DetailListView: View {
    
    let restaurant: Business
    
    var body: some View {
        // Populating various business info cells
        VStack(spacing: 0) {
            Section {
                if let hours = restaurant.businessHours?.first,
                   let hoursString = hours.hoursDisplayString {
                    let values: [String] = [hours.isOpenNow ? "Open now" : "Closed Now", hoursString]
                    DetailCellView(title: "Hours", values: values)
                }
                
                if let price = restaurant.price {
                    DetailCellView(title: "Price", values: [price])
                }
                
                if restaurant.displayPhone != "" {
                    DetailCellView(title: "Phone", values: [restaurant.displayPhone])
                }
                
                if !restaurant.location.displayAddress.isEmpty {
                    DetailCellView(title: "Address", values: restaurant.location.displayAddress)
                }
            } header: {
                SectionHeader(labelText: "Business Info")
            }
        }
    }
}
