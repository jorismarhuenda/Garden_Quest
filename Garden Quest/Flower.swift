//
//  Flower.swift
//  Garden Quest
//
//  Created by marhuenda joris on 06/08/2023.
//

import SwiftUI

// MARK: - Flower Model
struct Flower: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var isWatered: Bool = false
    var isRare: Bool = false
    var growthStage: Int = 0
    var growthTime: Int // Time to reach full growth (in seconds)
}
