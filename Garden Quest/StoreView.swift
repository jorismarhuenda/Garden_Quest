//
//  StoreView.swift
//  Garden Quest
//
//  Created by marhuenda joris on 06/08/2023.
//

import SwiftUI

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

struct StoreView_Previews: PreviewProvider {
        static var previews: some View {
            StoreView(viewModel: GardenViewModel())
        }
    }
