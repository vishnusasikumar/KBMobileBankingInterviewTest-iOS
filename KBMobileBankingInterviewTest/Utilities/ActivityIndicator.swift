//
//  ActivityIndicator.swift
//  KBMobileBankingInterviewTest
//
//  Created by Admin on 25/07/2025.
//

import SwiftUI

struct ActivityIndicator: View {

    @State private var isAnimating: Bool = false
    var colors: [Color] = [Color.accentColor, Color.white]

    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<5) { _ in
                Circle()
                    .trim(from: 0.75, to: 1.0)
                    .stroke(lineWidth: 16)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
                    .animation(Animation
                        .linear(duration: 1)
                        .repeatForever(autoreverses: false), value: UUID())
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            self.isAnimating = true
        }
    }

    func calcScale(index: Int) -> CGFloat {
        return (!isAnimating ? 1 - CGFloat(Float(index)) / 5 : 0.2 + CGFloat(index) / 5)
    }

    func calcYOffset(_ geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width / 10 - geometry.size.height / 2
    }
}

#Preview {
    ActivityIndicator()
        .frame(width: 60, height: 60)
        .foregroundColor(.accent)
}
