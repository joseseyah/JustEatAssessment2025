//
//  ResultsView.swift
//  JustEat
//
//  Created by Joseph Hayes on 01/04/2025.
//

import SwiftUI

struct ResultsView: View {
    let selectedCategory: String

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 1.0, green: 0.7, blue: 0.2),
                    Color(red: 1.0, green: 0.45, blue: 0.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                Spacer()

                Text(selectedCategory)
                    .font(.system(size: 32, weight: .black, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 12)
                    .background(Color.orange.opacity(0.9))
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 4)

                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
    }
}

