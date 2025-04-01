//
//  RestaurantCardView.swift
//  JustEat
//
//  Created by Joseph Hayes on 31/03/2025.
//

import SwiftUI

struct RestaurantCardView: View {
    let restaurant: Restaurant

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(restaurant.name)
                .font(.headline)
                .fontWeight(.semibold)
                .lineLimit(1)

          if let cuisines = restaurant.cuisines?.first{
                Text(cuisines.name)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            Spacer()

            if let rating = restaurant.rating?.starRating {
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.orange)
                        .font(.caption)
                    Text(String(format: "%.1f", rating))
                        .font(.caption)
                        .foregroundColor(.orange)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 100, alignment: .leading)
        .background(Color(red: 1.0, green: 0.95, blue: 0.9))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
    }
}




