//
//  Player.swift
//  Garden Quest
//
//  Created by marhuenda joris on 06/08/2023.
//

import SwiftUI

// MARK: - Player
struct Player {
    var name: String
    var level: Int
    var experience: Int
    var score: Int
    var achievements: [Achievement]
    var purchasedFlowers: [Flower] // Changed from [Item] to [Flower]

    init(name: String) {
        self.name = name
        self.level = 1
        self.experience = 0
        self.score = 0
        self.achievements = []
        self.purchasedFlowers = []
    }
    
    
    // Function to check if the player has leveled up
    mutating func checkLevelUp(flowers: [Flower]) {
            let requiredExperience = 50 * Int(pow(2.0, Double(level - 1))) // Formula to calculate required experience for each level
            if experience >= requiredExperience {
                level += 1

                // Reward the player with a random flower from the shop
                if let randomFlower = flowers.randomElement(), !purchasedFlowers.contains(randomFlower) {
                    purchasedFlowers.append(randomFlower)
                }
            }
        }
}
