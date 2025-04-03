//
//  OnboardingView.swift
//  JustEat
//
//  Created by Joseph Hayes on 02/04/2025.
//

import SwiftUI

struct OnboardingView: View {
    @State private var postcode: String = ""
    @AppStorage("userPostcode") var savedPostcode: String = ""
    @State private var isSubmitted = false
    @ObservedObject var viewModel: RestaurantViewModel

    var body: some View {
        VStack(spacing: 24) {
            Text("Welcome to JustPick")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)

            Text("Enter your postcode to find nearby restaurants")
                .font(.headline)
                .multilineTextAlignment(.center)

            TextField("Postcode", text: $postcode)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .keyboardType(.default)
                .autocapitalization(.allCharacters)

            Button(action: {
                if !postcode.trimmingCharacters(in: .whitespaces).isEmpty {
                    savedPostcode = postcode
                    isSubmitted = true
                }
            }) {
                Text("Continue")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .fullScreenCover(isPresented: $isSubmitted) {
            HomeView(viewModel: viewModel)
        }
    }
}

