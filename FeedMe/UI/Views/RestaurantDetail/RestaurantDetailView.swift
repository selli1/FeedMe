//
//  RestaurantDetailView.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/9/25.
//

import SwiftUI

struct RestaurantDetailView: View {
    let restaurant: Business
    @State private var scrollOffset: CGFloat = 0
    @State private var emptySpace: CGFloat = 0
    
    var body: some View {
        
        let headerHeight: CGFloat = 300
        let overlapHeight: CGFloat = 20
        
        ZStack(alignment: .top) {
            CustomGradient().overlay(ThinMaterial())
            AsyncImageView(url: URL(string: restaurant.imageURL ?? ""))
                .frame(maxWidth: UIScreen.main.bounds.width)
                .frame(height: headerHeight + overlapHeight + max(0, -scrollOffset))
                .clipped()
                .transformEffect(.init(translationX: 0, y: -(max(0, scrollOffset))))
                .overlay {
                    DetailHeaderView(restaurant: restaurant)
                        .padding(.bottom, overlapHeight)
                }

            ScrollView(.vertical) {
                Spacer()
                    .frame(height: headerHeight)
                
                VStack(spacing: 0) {
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
                    
                    Color.clear.overlay(ThinMaterial())
                        .frame(height: emptySpace)
                }
                .background(CustomGradient().overlay(ThinMaterial()))
            }
            .onScrollGeometryChange(for: CGFloat.self, of: { geo in
                return geo.contentOffset.y + geo.contentInsets.top
            }, action: { new, old in
                scrollOffset = new
            })
            .onScrollGeometryChange(for: CGFloat.self, of: { geo in
                return geo.containerSize.height - geo.contentSize.height
            }, action: { new, old in
                emptySpace = new >= 0 ? new : 0
            })
        }
        .ignoresSafeArea()
    }
}
