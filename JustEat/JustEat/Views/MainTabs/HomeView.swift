//
//  Home.swift
//  JustEat
//
//  Created by Joseph Hayes on 27/03/2025.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("userPostcode") private var postcode: String = ""
    @StateObject private var viewModel = RestaurantViewModel()
    @State private var hasLoaded = false

    var body: some View {
        NavigationView {
            ZStack {
                // 🍊 Gradient Background
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 1.0, green: 0.7, blue: 0.2),
                        Color(red: 1.0, green: 0.45, blue: 0.0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {
                    // 🟠 Title Capsule (UI always visible)
                    Text("Restaurants")
                        .font(.system(size: 32, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(Color.orange.opacity(0.9))
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 4)
                        .padding(.top, 20)

                    Spacer(minLength: 10)

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
                            Spacer()
                        } else {
                            ScrollView {
                                LazyVStack(spacing: 16) {
                                    ForEach(viewModel.restaurants) { restaurant in
                                        RestaurantCardView(restaurant: restaurant)
                                            .padding(.horizontal)
                                    }
                                }
                                .padding(.top)
                            }
                        }
                    }

                    Spacer()
                }
                .padding(.horizontal)
                .onAppear {
                    if !hasLoaded && !postcode.isEmpty {
                        viewModel.fetchRestaurants(postcode: postcode)
                        hasLoaded = true
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}



#Preview {
  HomeView()
}
