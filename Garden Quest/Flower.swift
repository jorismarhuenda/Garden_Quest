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
    let imageName: String 
    
    // Define a static property 'availableFlowers' containing valid flowers
       static let availableFlowers: [Flower] = [
           Flower(name: "Daisy", growthTime: 30, imageName: "Daisy"),
           Flower(name: "Rose", growthTime: 45, imageName: "Rose"),
           Flower(name: "Lily", growthTime: 8, imageName: "Lily"),
           Flower(name: "Sunflower", growthTime: 12, imageName: "Sunflower"),
           Flower(name: "Tulip", growthTime: 6, imageName: "Tulip"),
           Flower(name: "Daffodil", growthTime: 7, imageName: "Daffodil"),
           Flower(name: "Orchid", growthTime: 9, imageName: "Orchid"),
           Flower(name: "Peony", growthTime: 11, imageName: "Peony"),
           Flower(name: "Carnation", growthTime: 5, imageName: "Carnation"),
           Flower(name: "Bluebell", growthTime: 8, imageName: "Bluebell"),
           Flower(name: "Cherry Blossom", growthTime: 7, imageName: "Cherry Blossom"),
           Flower(name: "Hydrangea", growthTime: 10, imageName: "Hydrangea"),
           Flower(name: "Hibiscus", growthTime: 9, imageName: "Hibiscus"),
           Flower(name: "Marigold", growthTime: 6, imageName: "Marigold"),
           Flower(name: "Dahlia", growthTime: 11, imageName: "Dahlia"),
           Flower(name: "Poppy", growthTime: 5, imageName: "Poppy"),
           Flower(name: "Iris", growthTime: 7, imageName: "Iris"),
           Flower(name: "Crocus", growthTime: 8, imageName: "Crocus"),
           Flower(name: "Lavender", growthTime: 9, imageName: "Lavender"),
           Flower(name: "Zinnia", growthTime: 10, imageName: "Zinnia"),
       ]
}
