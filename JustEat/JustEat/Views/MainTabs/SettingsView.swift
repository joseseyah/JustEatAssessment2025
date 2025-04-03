//
//  SettingsView.swift
//  JustEat
//
//  Created by Joseph Hayes on 31/03/2025.
//


import SwiftUI

struct SettingsView: View {
    @AppStorage("userPostcode") private var userPostcode: String = ""
    @State private var tempPostcode: String = ""
    @State private var showingSaved = false
    var viewModel: RestaurantViewModel

    var body: some View {
        ZStack {
            // Just Eat orange gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 1.0, green: 0.6, blue: 0.2),
                    Color(red: 1.0, green: 0.4, blue: 0.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 25) {
                // Header
                Text("Settings")
                    .font(.system(size: 32, weight: .black, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    .padding(.top, 30)

                Spacer().frame(height: 20)

                // Delivery address section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Delivery Address")
                        .font(.headline)
                        .foregroundColor(.black)

                    Text("What is your Address?")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    // White card with postcode
                    Text(userPostcode.isEmpty ? "Not set yet" : userPostcode.uppercased())
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color.orange)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(12)

                    // Light orange input field
                    TextField("Enter a new postcode", text: $tempPostcode)
                        .padding()
                        .background(Color(red: 1.0, green: 0.9, blue: 0.8))
                        .cornerRadius(12)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)

                    // Light orange button
                    Button(action: {
                        if !tempPostcode.trimmingCharacters(in: .whitespaces).isEmpty {
                            userPostcode = tempPostcode
                            Task {
                                await viewModel.fetchRestaurants(postcode: tempPostcode)
                            }
                            tempPostcode = ""
                            withAnimation { showingSaved = true }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation { showingSaved = false }
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "externaldrive.fill")
                            Text("Save Postcode")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 1.0, green: 0.6, blue: 0.2)) // lighter orange
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }

                    if showingSaved {
                        Text("✅ Postcode saved!")
                            .foregroundColor(.orange)
                            .transition(.opacity)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .padding(.horizontal)

                Spacer()
            }
        }
    }
}





