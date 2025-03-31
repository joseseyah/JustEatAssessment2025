//
//  FoodWheelView.swift
//  JustEat
//
//  Created by Joseph Hayes on 27/03/2025.
//

import SwiftUI

struct FoodSlotMachineView: View {
    let foods = ["🍕", "🍔", "🍣", "🌮", "🍝", "🍛", "🍜", "🥙"]

    @State private var reelIndex = 0
    @State private var isSpinning = false
    @State private var selectedItem: String? = nil
    @State private var showConfetti = false

    var body: some View {
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

            VStack(spacing: 20) {
              Text("Random Food!")
                  .font(.system(size: 32, weight: .black, design: .rounded))
                  .foregroundColor(.white)
                  .padding(.horizontal, 24)
                  .padding(.vertical, 10)
                  .background(Color.orange.opacity(0.9))
                  .cornerRadius(20)
                  .shadow(color: .black.opacity(0.3), radius: 4, x: 2, y: 4)

                ZStack {
                    VStack(spacing: 0) {
                        Image("RandomMachine")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 400)
                        Spacer()
                    }

                    VStack {
                        Spacer()
                            .frame(height: 125)

                        Text(foods[reelIndex])
                            .font(.system(size: 60))
                            .shadow(color: .white.opacity(0.8), radius: 2, x: 0, y: 2)
                            .offset(x: -8, y: 0)

                        Spacer()
                    }
                }
                .frame(height: 400)


                if let item = selectedItem, !isSpinning {
                    Text("You got: \(item)")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 2)
                }

                Button(action: spin) {
                    Text("Find my cuisine...")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 14)
                        .background(Color.white)
                        .foregroundColor(.orange)
                        .cornerRadius(14)
                        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                }
                .disabled(isSpinning)

                Spacer()
            }
            .padding()

            if showConfetti {
                ConfettiView()
                    .transition(.opacity)
            }
        }
    }

    func spin() {
        guard !isSpinning else { return }
        isSpinning = true
        showConfetti = false
        selectedItem = nil

        let totalSteps = 30
        let targetIndex = Int.random(in: 0..<foods.count)
        gradualSpin(step: 1, totalSteps: totalSteps, targetIndex: targetIndex)
    }

    func gradualSpin(step: Int, totalSteps: Int, targetIndex: Int) {
        if step > totalSteps {
            reelIndex = targetIndex
            isSpinning = false
            selectedItem = foods[targetIndex]

            withAnimation { showConfetti = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation { showConfetti = false }
            }
            return
        }

        reelIndex = (reelIndex + 1) % foods.count
        let progress = Double(step) / Double(totalSteps)
        let interval = 0.05 + (0.3 - 0.05) * progress

        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            gradualSpin(step: step + 1, totalSteps: totalSteps, targetIndex: targetIndex)
        }
    }
}

// MARK: - Preview
struct FoodSlotMachineView_Previews: PreviewProvider {
    static var previews: some View {
        FoodSlotMachineView()
            .previewDevice("iPhone 14 Pro")
    }
}
