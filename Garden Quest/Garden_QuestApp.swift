//
//  Garden_QuestApp.swift
//  Garden Quest
//
//  Created by marhuenda joris on 01/08/2023.
//

import SwiftUI

// MARK: - Flower Model
struct Flower: Identifiable {
    let id = UUID()
    let name: String
    var isWatered: Bool = false
    var isRare: Bool = false
    var growthStage: Int = 0
    var growthTime: Int // Time to reach full growth (in seconds)
}

// MARK: - Quest Model
class Quest: Identifiable, ObservableObject {
    let id = UUID()
    let title: String
    let description: String
    @Published var isCompleted: Bool = false
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}

// MARK: - Achievement Model
class Achievement: Identifiable, ObservableObject {
    let id = UUID()
    let title: String
    let description: String
    @Published var isCompleted: Bool = false
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}

// MARK: - GardenViewModel
class GardenViewModel: ObservableObject {
    @Published var flowers: [Flower] = []
    @Published var coins: Int = 0
    @Published var quests: [Quest] = []
    @Published var achievements: [Achievement] = []
    @Published var isShowingInsufficientCoinsAlert: Bool = false
    @Published var isShowingStore: Bool = false
    @Published var didShowStore: Bool = false

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
        } else {
            isShowingInsufficientCoinsAlert = true
        }
    }

    func collectCoins() {
        coins += 10 // Reward the player with coins
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



// MARK: - GardenView
struct GardenView: View {
    @StateObject private var viewModel = GardenViewModel()
    @State private var isShowingStore: Bool = false // A flag to show/hide the in-app store

    var body: some View {
        ZStack {
            // Background Color
            Color.green
            .edgesIgnoringSafeArea(.all)
        VStack {
            Text("Garden Quest")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
            
            // Flower Garden
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(viewModel.flowers) { flower in
                        FlowerView(flower: flower)
                            .onTapGesture {
                                viewModel.waterFlower(flower)
                            }
                    }
                }
            }
            
            // Plant Button
            HStack {
                Button(action: {
                    viewModel.plantFlower("Daisy", growthTime: 6)
                }) {
                    Text("Plant Daisy Seed (Cost: 5 Coins, Growth Time: 6 seconds)")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Button(action: {
                    isShowingStore.toggle()
                }) {
                    Text("Open In-App Store")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()

            // Display coins in real-time
                        HStack {
                            Image(systemName: "dollarsign.circle")
                                .font(.title)
                            Text("\(viewModel.coins)")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .padding()
            
            // Quests and Achievements
            VStack {
                Text("Quests:")
                    .font(.title)
                    .foregroundColor(.white)
                ForEach(viewModel.quests) { quest in
                    Text("\(quest.title) - \(quest.isCompleted ? "Completed" : "In Progress")")
                    .foregroundColor(.white)
                }

                Text("Achievements:")
                    .font(.title)
                    .foregroundColor(.white)
                ForEach(viewModel.achievements) { achievement in
                    Text("\(achievement.title) - \(achievement.isCompleted ? "Completed" : "In Progress")")
                    .foregroundColor(.white)
                }
            }
            
            // Show Store Button
                        Button(action: {
                            viewModel.isShowingStore = true
                        }) {
                            Text("Open Store")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding()
                    }
                    .padding()
                    .sheet(isPresented: $viewModel.isShowingStore) {
                        StoreView(viewModel: viewModel)
                            .onAppear {
                                viewModel.didShowStore = true
                            }
                    }
                        .alert(isPresented: $viewModel.isShowingInsufficientCoinsAlert) {
                            Alert(
                                title: Text("Insufficient Coins"),
                                message: Text("You don't have enough coins to plant a new flower."),
                                dismissButton: .default(Text("Got it!"))
                            )
                        }
                        .sheet(isPresented: $isShowingStore) {
                            StoreView(viewModel: viewModel)
                                .environmentObject(viewModel) // Pass the GardenViewModel to the StoreView
            }
        }
    }
}

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

// MARK: - StoreView
struct StoreView: View {
    @ObservedObject var viewModel: GardenViewModel
    @State private var isShowingAlert: Bool = false

    var body: some View {
        ZStack {
            // Background Color
            Color.blue
            .edgesIgnoringSafeArea(.all)

    ScrollView {
        VStack {
            Text("In-App Store")
                .font(.title)
                .foregroundColor(.white)
                .padding()

            HStack {
                Button(action: {
                    viewModel.collectCoins()
                    isShowingAlert = true
                }) {
                    Text("Buy 10 Coins (Free)")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Button(action: {
                    viewModel.buyAccelerator()
                }) {
                    Text("Buy Flower Accelerator (Cost: 20 Coins)")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()

            // Flower seeds for sale
                        VStack {
                            Text("Flower Seeds:")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.top)
                            ForEach(viewModel.availableSeeds) { seed in
                                Button(action: {
                                    viewModel.buySeed(seed.flower, cost: seed.cost)
                                }) {
                                    HStack {
                                        Image(systemName: "seedling")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.green)

                                        Text("\(seed.flower.name) Seed")
                                            .font(.headline)
                                            .foregroundColor(.white)

                                        Text("Cost: \(seed.cost) Coins, Growth Time: \(seed.flower.growthTime) seconds")
                                            .font(.subheadline)
                                            .foregroundColor(.white)

                                        Spacer()
                                    }
                                    .padding()
                                    .background(Color.yellow)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .disabled(viewModel.coins < seed.cost) // Disable the button if not enough coins
                    }
                                .padding(.bottom, 10)
                }
            }
        }
        .padding()
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("Coins Purchased"), message: Text("You received 10 coins for free!"), dismissButton: .default(Text("Got it!")))
        }
        .alert(isPresented: $viewModel.isShowingInsufficientCoinsAlert) {
                    Alert(title: Text("Insufficient Coins"), message: Text("You don't have enough coins to buy this seed."), dismissButton: .default(Text("Got it!")))
                }
            }
        }
    }
}
    
// MARK: - Previews
struct GardenView_Previews: PreviewProvider {
        static var previews: some View {
            GardenView()
        }
    }

struct StoreView_Previews: PreviewProvider {
        static var previews: some View {
            StoreView(viewModel: GardenViewModel())
        }
    }

// MARK: - Main App
@main
struct GardenQuestApp: App {
    var body: some Scene {
        WindowGroup {
            GardenView()
        }
    }
}

