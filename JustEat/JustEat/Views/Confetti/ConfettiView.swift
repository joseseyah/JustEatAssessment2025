//
//  ConfettiView.swift
//  JustEat
//
//  Created by Joseph Hayes on 27/03/2025.
//
import SwiftUI

struct ConfettiView: View {
    @State private var confettiPieces: [ConfettiPiece] = (0..<30).map { _ in ConfettiPiece() }

    var body: some View {
        ZStack {
            ForEach(confettiPieces) { piece in
                ConfettiShape(piece: piece)
            }
        }
        .allowsHitTesting(false)
    }
}
