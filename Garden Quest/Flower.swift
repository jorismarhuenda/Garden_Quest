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
    let name: String
    var isWatered: Bool = false
    var isRare: Bool = false
    var growthStage: Int = 0
    let growthTime: Int // Time to reach full growth (in seconds)
    
    // Define a static property 'availableFlowers' containing valid flowers
       static let availableFlowers: [Flower] = [
           Flower(name: "Daisy", growthTime: 30),
           Flower(name: "Rose", growthTime: 45),
           Flower(name: "Lily", growthTime: 8),
           Flower(name: "Sunflower", growthTime: 12),
           Flower(name: "Tulip", growthTime: 6),
           Flower(name: "Daffodil", growthTime: 7),
           Flower(name: "Orchid", growthTime: 9),
           Flower(name: "Peony", growthTime: 11),
           Flower(name: "Carnation", growthTime: 5),
           Flower(name: "Bluebell", growthTime: 8),
           Flower(name: "Cherry Blossom", growthTime: 7),
           Flower(name: "Hydrangea", growthTime: 10),
           Flower(name: "Hibiscus", growthTime: 9),
           Flower(name: "Marigold", growthTime: 6),
           Flower(name: "Dahlia", growthTime: 11),
           Flower(name: "Poppy", growthTime: 5),
           Flower(name: "Iris", growthTime: 7),
           Flower(name: "Crocus", growthTime: 8),
           Flower(name: "Lavender", growthTime: 9),
           Flower(name: "Zinnia", growthTime: 10),
       ]
}
