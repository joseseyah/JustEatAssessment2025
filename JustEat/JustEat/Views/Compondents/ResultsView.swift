//
//  ResultsView.swift
//  JustEat
//
//  Created by Joseph Hayes on 01/04/2025.
//

import SwiftUI

struct ResultsView: View {
    let selectedCategory: String

    @StateObject private var viewModel = RestaurantViewModel()
    @AppStorage("userPostcode") private var postcode: String = ""
    @State private var hasLoaded = false

    var body: some View {
      NavigationView{
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 1.0, green: 0.6, blue: 0.2),
                    Color(red: 1.0, green: 0.4, blue: 0.0)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack {
                Spacer()

                Text(selectedCategory)
                    .font(.system(size: 32, weight: .black, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 12)

                Spacer()

                if viewModel.restaurants.isEmpty {
                    Spacer()
                    ProgressView("Loading restaurants...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .foregroundColor(.white)
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.restaurants) { restaurant in
                                NavigationLink(destination: RestaurantView(restaurant: restaurant)) {
                                    RestaurantCardView(restaurant: restaurant)
                                        .padding(.horizontal)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.top)
                    }
                }


            }
            .frame(maxWidth: .infinity)
            .padding()
            .onAppear{
              if !hasLoaded && !postcode.isEmpty{
                Task {
                  await viewModel.fetchRestaurants(postcode: postcode, filterByCuisine: selectedCategory)
                    hasLoaded = true
                }
              }
            }
        }
      }

    }
}

