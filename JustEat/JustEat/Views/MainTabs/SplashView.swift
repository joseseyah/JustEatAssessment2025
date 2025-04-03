//
//  SplashView.swift
//  JustEat
//
//  Created by Joseph Hayes on 03/04/2025.
//


import SwiftUI

struct SplashView: View {
    @AppStorage("userPostcode") private var userPostcode: String = ""
    @StateObject private var viewModel = RestaurantViewModel()

    @State private var isReady = false
    @State private var animateExpand = false
    @State private var logoOpacity: Double = 0.0

    var body: some View {
        if isReady {
            if userPostcode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                OnboardingView(viewModel: viewModel)
            } else {
                ContentView()
            }
        } else {
            ZStack {
                Color(red: 1.0, green: 0.42, blue: 0.0).ignoresSafeArea()

                Image("Animatedlaunch")
                    .resizable()
                    .scaledToFit()
                    .opacity(1)
                    .scaleEffect(animateExpand ? 12 : 1)
                    .frame(width: animateExpand ? UIScreen.main.bounds.width : 200)
                    .onAppear {
                        withAnimation(.easeOut(duration: 1.0)) {

                        }

                        Task {
                            if !userPostcode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                await viewModel.fetchRestaurants(postcode: userPostcode)
                            }
                            //make look cool
                            withAnimation(.easeInOut(duration: 0.8)) {
                                animateExpand = true
                            }

                            try? await Task.sleep(nanoseconds: 900_000_000)

                            isReady = true
                        }
                    }
            }
        }
    }
}


