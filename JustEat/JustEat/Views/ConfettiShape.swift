//
//  ConfettiShape.swift
//  JustEat
//
//  Created by Joseph Hayes on 27/03/2025.
//
import SwiftUI

struct ConfettiShape: View {
    let piece: ConfettiPiece
    @State private var yOffset: CGFloat = -50
    @State private var finalRotation: Double = 0

    var body: some View {
        GeometryReader { geo in
            shape
                .foregroundColor(piece.color)
                .frame(width: piece.size, height: piece.size)
                .rotationEffect(.degrees(piece.rotation))
                .rotation3DEffect(.degrees(finalRotation), axis: (x: 0, y: 0, z: 1))
                .position(x: piece.x * geo.size.width, y: yOffset)
                .onAppear {
                    withAnimation(.linear(duration: piece.speed)) {
                        yOffset = geo.size.height + piece.size
                        finalRotation = piece.rotation + 360
                    }
                }
        }
    }

    @ViewBuilder
    private var shape: some View {
        switch piece.shapeType {
        case 0:
            Circle()
        case 1:
            Rectangle()
        default:
            Capsule()
        }
    }
}
