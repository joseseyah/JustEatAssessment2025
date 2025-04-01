//
//  RestaurantView.swift
//  JustEat
//
//  Created by Joseph Hayes on 01/04/2025.
//

import SwiftUI

struct RestaurantView: View {
    let restaurant: Restaurant

    var body: some View {
        ZStack {
            // Background matches home screen
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 1.0, green: 0.6, blue: 0.2),
                    Color(red: 1.0, green: 0.4, blue: 0.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer().frame(height: 20)

                // Image
                if let logoURL = restaurant.logoURL,
                   let url = URL(string: logoURL) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(radius: 5)
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white.opacity(0.3))
                            .frame(width: 100, height: 100)
                    }
                }

                // Name
                Text(restaurant.name)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                // White info card
                VStack(alignment: .leading, spacing: 16) {
                    if let cuisine = restaurant.cuisines?.first {
                        HStack {
                            Text("Cuisine:")
                                .foregroundColor(.gray)
                            Spacer()
                            Text(cuisine.name)
                                .foregroundColor(.black)
                        }
                    }

                    if let rating = restaurant.rating?.starRating {
                        HStack {
                            Text("Rating:")
                                .foregroundColor(.gray)
                            Spacer()
                            Label(String(format: "%.1f", rating), systemImage: "star.fill")
                                .foregroundColor(.orange)
                        }
                    }

                    if let address = restaurant.address {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Address:")
                                .foregroundColor(.gray)
                            Text(address.firstLine)
                                .foregroundColor(.black)
                            Text(address.postalCode)
                                .foregroundColor(.black)
                        }
                    }
                    if let location = restaurant.address?.location, location.coordinates.count == 2 {
                        let coords = location.coordinates
                        RestaurantMapView(latitude: coords[1], longitude: coords[0], name: restaurant.name)
                            .padding(.top, 12)
                    }

                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                .padding(.horizontal)

                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

