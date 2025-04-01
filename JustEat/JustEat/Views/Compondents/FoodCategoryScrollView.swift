//
//  FoodCategoryScrollView.swift
//  JustEat
//
//  Created by Joseph Hayes on 01/04/2025.
//


import SwiftUI

struct FoodCategoryScrollView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(FoodOptions.all.sorted(by: { $0.value < $1.value }), id: \.key) { emoji, name in
                    VStack(spacing: 8) {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 60, height: 60)
                                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)

                            Text(emoji)
                                .font(.system(size: 28))
                        }

                        Text(name)
                            .font(.footnote)
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .frame(width: 60)
                            .multilineTextAlignment(.center)
                    }
                    .transition(.scale)
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 10)
    }
}

