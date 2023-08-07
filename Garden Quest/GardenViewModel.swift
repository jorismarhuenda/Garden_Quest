//
//  GardenViewModel.swift
//  Garden Quest
//
//  Created by marhuenda joris on 06/08/2023.
//

import SwiftUI

// MARK: - GardenViewModel
class GardenViewModel: ObservableObject {
    @Published var flowers: [Flower] = []
    @Published var coins: Int = 0
    @Published var quests: [Quest] = []
    @Published var achievements: [Achievement] = []
    @Published var isShowingInsufficientCoinsAlert: Bool = false
    @Published var isShowingStore: Bool = false
    @Published var didShowStore: Bool = false
    @Published var player: Player // Player property added
    @Published var availableShopItems: [ShopItem] = [
            ShopItem(name: "Daisy Seed", price: 10, category: .seed),
            ShopItem(name: "Rose Seed", price: 15, category: .seed),
            ShopItem(name: "Accelerator 2x", price: 20, category: .item),
            ShopItem(name: "Accelerator 5x", price: 50, category: .item)
        ]
    @Published var selectedCategory: ShopCategory = .seed
    @Published var purchasedSeeds: [Seed] = []
    @Published var purchasedFlowers: [Flower] = []
    @Published var showAlertWaitForFreeCoins = false
    @Published var alertWaitForFreeCoinsMessage = ""

    struct Seed: Identifiable { // Add Identifiable conformance here
            let id = UUID()
            let flower: Flower
            let cost: Int
        }

    var availableSeeds: [Seed] {
        return [
            Seed(flower: Flower(name: "Rose", growthTime: 10), cost: 20),
            Seed(flower: Flower(name: "Lily", growthTime: 8), cost: 15),
            Seed(flower: Flower(name: "Sunflower", growthTime: 12), cost: 25),
            Seed(flower: Flower(name: "Tulip", growthTime: 6), cost: 10),
            Seed(flower: Flower(name: "Daffodil", growthTime: 7), cost: 12),
            Seed(flower: Flower(name: "Orchid", growthTime: 9), cost: 18),
            Seed(flower: Flower(name: "Peony", growthTime: 11), cost: 22),
            Seed(flower: Flower(name: "Carnation", growthTime: 5), cost: 8),
            Seed(flower: Flower(name: "Daisy", growthTime: 6), cost: 10),
            Seed(flower: Flower(name: "Bluebell", growthTime: 8), cost: 14),
            Seed(flower: Flower(name: "Cherry Blossom", growthTime: 7), cost: 13),
            Seed(flower: Flower(name: "Hydrangea", growthTime: 10), cost: 20),
            Seed(flower: Flower(name: "Hibiscus", growthTime: 9), cost: 17),
            Seed(flower: Flower(name: "Marigold", growthTime: 6), cost: 10),
            Seed(flower: Flower(name: "Dahlia", growthTime: 11), cost: 24),
            Seed(flower: Flower(name: "Poppy", growthTime: 5), cost: 9),
            Seed(flower: Flower(name: "Iris", growthTime: 7), cost: 12),
            Seed(flower: Flower(name: "Crocus", growthTime: 8), cost: 15),
            Seed(flower: Flower(name: "Lavender", growthTime: 9), cost: 18),
            Seed(flower: Flower(name: "Zinnia", growthTime: 10), cost: 20),
        ]
    }

    init() {
        // Initialize the garden with some default flowers (You can load from data, etc.)
        flowers = [
            Flower(name: "Rose", growthTime: 10),
            Flower(name: "Lily", growthTime: 8),
            // Add more initial flowers as needed
        ]

        // Add some example quests and achievements
        quests = [
            Quest(title: "Water 5 Flowers", description: "Water 5 different flowers in your garden."),
            // Add more quests as needed
        ]

        achievements = [
            Achievement(title: "Novice Gardener", description: "Complete your first quest."),
            // Add more achievements as needed
        ]
        self.player = Player(name: "Player") // Initialize the player with a default name
    }

    private func timeRemainingForNextFreeCoins() -> String {
            let currentTimeStamp = Date().timeIntervalSince1970
            let lastReceivedTimestamp = UserDefaults.standard.double(forKey: "LastReceivedTimestamp")
            let timeInterval = 24 * 60 * 60 - (currentTimeStamp - lastReceivedTimestamp)
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.hour, .minute, .second]
            formatter.unitsStyle = .abbreviated
            return formatter.string(from: TimeInterval(timeInterval)) ?? ""
        }
    
    // Function to buy an item from the shop
        func buyShopItem(_ item: ShopItem) {
            if coins >= item.price {
                coins -= item.price
                switch item.category {
                case .seed:
                    // Ensure the provided item name is a valid flower name
                    if let flower = Flower.availableFlowers.first(where: { $0.name == item.name }) {
                        // Add the purchased seed to the player's inventory
                        let seed = Seed(flower: flower, cost: item.price)
                        purchasedSeeds.append(seed)
                    }
                case .item:
                    // Add the purchased item to the player's inventory
                    let purchasedItem = Items(name: item.name)
                    player.purchasedItems.append(purchasedItem)
                }
            } else {
                isShowingInsufficientCoinsAlert = true
            }
        }
    
    func buySeed(_ flower: Flower, cost: Int) {
            if coins >= cost {
                coins -= cost
                plantFlower(flower.name, growthTime: flower.growthTime)
            } else {
                isShowingInsufficientCoinsAlert = true
            }
        }
    
    func waterFlower(_ flower: Flower) {
        if let index = flowers.firstIndex(where: { $0.id == flower.id }) {
            flowers[index].isWatered = true
            flowers[index].growthStage += 1
            coins += 1 // Reward the player with coins for watering flowers

            // Check for quest completion
            checkQuests()
        }
    }

    func plantFlower(_ flowerName: String, growthTime: Int) {
        if coins >= 5 { // Check if the player has enough coins
        let newFlower = Flower(name: flowerName, growthTime: growthTime)
        flowers.append(newFlower)
        coins -= 5 // Deduct coins from the player for planting a new flower
        // Update player experience when planting a flower
        player.experience += 10
        checkLevelUp()
        } else {
            isShowingInsufficientCoinsAlert = true
        }
    }
    
    func collectCoins() {
        coins += 10 // Reward the player with coins
    }
    
    // Function to check if the player has leveled up
        private func checkLevelUp() {
            player.checkLevelUp(flowers: flowers)
        }

    func buyAccelerator() {
            if coins >= 20 {
                coins -= 20
                // Add code to accelerate flower growth (e.g., double growth stage increment)
            } else {
                isShowingInsufficientCoinsAlert = true
            }
        }

    private var mutableQuests: [Quest] {
            return quests.map { quest in
                let copy = Quest(title: quest.title, description: quest.description)
                copy.isCompleted = quest.isCompleted
                return copy
            }
        }
    
    // Function to receive free coins
        func receiveFreeCoins() {
            let currentTimeStamp = Date().timeIntervalSince1970
            let lastReceivedTimestamp = UserDefaults.standard.double(forKey: "LastReceivedTimestamp")

            // Check if 24 hours have passed since the last received time
            if currentTimeStamp - lastReceivedTimestamp >= 24 * 60 * 60 {
                coins += 10
                UserDefaults.standard.set(currentTimeStamp, forKey: "LastReceivedTimestamp")
            } else {
                // Show an alert indicating the remaining time for the next free coin reward
                let timeRemaining = timeRemainingForNextFreeCoins()
                showAlertWaitForFreeCoins = true
                alertWaitForFreeCoinsMessage = "You can receive free coins again in \(timeRemaining)."
            }
        }
    
    // Function to check for quest completion and update achievements
    private func checkQuests() {
            for quest in mutableQuests {
                if !quest.isCompleted {
                    let completedQuestsCount = flowers.filter { $0.isWatered }.count
                    if completedQuestsCount >= 5 { // Example condition for quest completion
                        if let index = quests.firstIndex(where: { $0.id == quest.id }) {
                            quests[index].isCompleted = true
                            coins += 5 // Reward the player for completing the quest
                            checkAchievements()
                        }
                    }
                }
            }
        }

    private var mutableAchievements: [Achievement] {
            return achievements.map { achievement in
                let copy = Achievement(title: achievement.title, description: achievement.description)
                copy.isCompleted = achievement.isCompleted
                return copy
            }
        }
    
    private func checkAchievements() {
            for achievement in mutableAchievements {
                if !achievement.isCompleted {
                    let completedQuestsCount = quests.filter { $0.isCompleted }.count
                    if completedQuestsCount >= 1 { // Example condition for achievement completion
                        if let index = achievements.firstIndex(where: { $0.id == achievement.id }) {
                            achievements[index].isCompleted = true
                            coins += 10 // Reward the player for completing the achievement
                        }
                    }
                }
            }
        }
}

