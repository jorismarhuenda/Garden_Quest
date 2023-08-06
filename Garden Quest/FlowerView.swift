//
//  FlowerView.swift
//  Garden Quest
//
//  Created by marhuenda joris on 06/08/2023.
//

import SwiftUI

// MARK: - FlowerView
struct FlowerView: View {
    let flower: Flower

    var body: some View {
        VStack {
            Image(systemName: flower.isWatered ? "drop.fill" : "drop")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(flower.isWatered ? .blue : .gray)

            Text(flower.name)
                .font(.headline)
                .foregroundColor(.white)

            Text("Stage: \(flower.growthStage)")
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.yellow)
        .cornerRadius(10)
    }
}
