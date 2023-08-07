//
//  GardenView.swift
//  Garden Quest
//
//  Created by marhuenda joris on 06/08/2023.
//

import SwiftUI

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
            
            // Experience Bar
                            VStack {
                                ProgressBar(progress: Double(viewModel.player.experience), total: Double(50 * Int(pow(2.0, Double(viewModel.player.level - 1)))))
                                    .frame(height: 20)
                                    .padding(.horizontal)

                                Text("Next Level: \(viewModel.player.level + 1)")
                                    .foregroundColor(.white)
                                    .padding(.trailing)
                            }
                            .padding(.top, 20)
            
            // Button to claim the daily reward
                        Button(action: {
                            viewModel.claimDailyReward()
                        }) {
                            Text("Claim Daily Reward (20 Coins)")
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .disabled(!viewModel.canClaimReward) // Disable the button if the reward is not available to claim
            
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

// MARK: - Previews
struct GardenView_Previews: PreviewProvider {
        static var previews: some View {
            GardenView()
        }
    }
