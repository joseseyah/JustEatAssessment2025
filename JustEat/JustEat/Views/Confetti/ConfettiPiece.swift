//
//  ConfettiPiece.swift
//  JustEat
//
//  Created by Joseph Hayes on 27/03/2025.
//

import SwiftUI

struct ConfettiPiece: Identifiable {
    let id = UUID()
    let x: CGFloat = CGFloat.random(in: 0.0...1.0)
    let size: CGFloat = CGFloat.random(in: 10...20)
    let shapeType: Int = Int.random(in: 0...2)
    let color: Color = [
        .red, .blue, .green, .yellow, .pink, .purple, .orange, .mint
    ].randomElement()!
    let rotation: Double = Double.random(in: 0..<360)
    let speed: Double = Double.random(in: 2...5)
}
