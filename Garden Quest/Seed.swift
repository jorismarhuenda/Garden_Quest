//
//  Seed.swift
//  Garden Quest
//
//  Created by marhuenda joris on 06/08/2023.
//

import SwiftUI

// MARK: - Seed
struct Seed {
    let flower: Flower
    let growthTime: Int

    // Initialize the Seed
    init(flower: Flower, cost: Int) {
        self.flower = flower
        self.growthTime = flower.growthTime
    }
}
