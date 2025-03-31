//
//  Home.swift
//  JustEat
//
//  Created by Joseph Hayes on 27/03/2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(
                    gradient: Gradient(colors: [
                        Color(red: 1.0, green: 0.75, blue: 0.3),
                        Color(red: 1.0, green: 0.45, blue: 0.0)
                    ]),
                    center: .center,
                    startRadius: 100,
                    endRadius: 500
                )
                .ignoresSafeArea()

                VStack(spacing: 40) {
                    // Just Eat themed headline
                    Text("🍽️ What's For Dinner?")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 1, y: 2)

                    // Description
                    Text("Feeling indecisive? Let the machine choose your next meal!")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)

                    // Navigation button
                    NavigationLink(destination: FoodSlotMachineView()) {
                        Text("🎰 Pick a Random Food")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 14)
                            .background(Color.white)
                            .foregroundColor(.orange)
                            .cornerRadius(14)
                            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                    }

                    Spacer()
                }
                .padding(.top, 100)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
