//
//  Home.swift
//  JustEat
//
//  Created by Joseph Hayes on 27/03/2025.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("userPostcode") private var postcode: String = ""
    @ObservedObject var viewModel: RestaurantViewModel
    @State private var hasLoaded = false
    @State private var selectedCategory: String? = nil


    var body: some View {
        NavigationView {
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

                VStack(spacing: 12) {
                    Text("Restaurants")
                        .font(.system(size: 32, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.top, 24)

                    if !postcode.isEmpty && !viewModel.restaurants.isEmpty {
                        HStack(spacing: 6) {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.white.opacity(0.9))

                            Text(postcode.uppercased())
                                .fontWeight(.black)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 5)
                                .background(Color.white.opacity(0.2))
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                        }
                        .font(.caption)
                    }

                    if postcode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Spacer()
                        Text("Nothing to View")
                            .font(.title2)
                            .foregroundColor(.white.opacity(0.8))
                        Spacer()
                    } else {
                        if viewModel.restaurants.isEmpty {
                            Spacer()
                            ProgressView("Loading restaurants...")
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .foregroundColor(.white)
                            Spacer(minLength: 10)
                        } else {
                            ScrollView {
                                FoodCategoryScrollView(selectedCategory: $selectedCategory) { selectedCuisine in
                                    Task {
                                        await viewModel.fetchRestaurants(postcode: postcode, filterByCuisine: selectedCuisine)
                                    }
                                }

                                .padding(.top, 4)

                                Text(selectedCategory.map { "\($0.capitalized) restaurants near you" } ?? "Popular restaurants near you")
                                    .font(.system(size: 18, weight: .black, design: .rounded))
                                    .foregroundColor(.orange)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color.white)
                                    .clipShape(Capsule())
                                    .padding(.top, 6)


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

                    Spacer(minLength: 0)
                }

                .padding(.horizontal)
                .onAppear {
                    if !hasLoaded && !postcode.isEmpty {
                        Task {
                            await viewModel.fetchRestaurants(postcode: postcode)
                            hasLoaded = true
                        }
                    }
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
        .task(id: postcode) {
            await viewModel.fetchRestaurants(postcode: postcode)
        }
    }
}



