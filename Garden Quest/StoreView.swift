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
    @State private var showAlertWaitForFreeCoins = false
    @State private var alertWaitForFreeCoinsMessage = ""

    var body: some View {
        NavigationView {
                    VStack {
                        Text("Shop").font(.largeTitle).padding(.top)
                        Picker("Category", selection: $viewModel.selectedCategory) {
                            ForEach(ShopCategory.allCases, id: \.self) { category in
                                Text(category.rawValue).tag(category)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        
                        // Button to receive free coins
                                    Button(action: {
                                        viewModel.receiveFreeCoins()
                                    }) {
                                        Text("Receive 10 Free Coins")
                                    }
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.green)
                                    .cornerRadius(10)
                                    .alert(isPresented: $showAlertWaitForFreeCoins) {
                                        Alert(
                                            title: Text("Wait for Free Coins"),
                                            message: Text(alertWaitForFreeCoinsMessage),
                                            dismissButton: .default(Text("OK"))
                                        )
                                    }
                        List(viewModel.availableShopItems.filter({ $0.category == viewModel.selectedCategory })) { item in
                            HStack {
                                Text(item.name)
                                Spacer()
                                Text("\(item.price) Coins")
                                Button(action: {
                                    viewModel.buyShopItem(item)
                                }) {

                                    NavigationView {
                                                VStack {
                                                    Text("Shop").font(.largeTitle).padding(.top)
                                                    Picker("Category", selection: $viewModel.selectedCategory) {
                                                        ForEach(ShopCategory.allCases, id: \.self) { category in
                                                            Text(category.rawValue).tag(category)
                                                        }
                                                    }
                                                    .pickerStyle(SegmentedPickerStyle())
                                                    .padding()

                                                    List(viewModel.availableShopItems.filter({ $0.category == viewModel.selectedCategory })) { item in
                                                        HStack {
                                                            Text(item.name)
                                                            Spacer()
                                                            Text("\(item.price) Coins")
                                                            Button(action: {
                                                                                        viewModel.buyShopItem(item) // Pass the 'item' as an argument
                                                                                    }) {
                                                                                        Text("Buy")
                                                                                            .padding(8)
                                                                                            .background(Color.blue)
                                                                                            .foregroundColor(.white)
                                                                                            .cornerRadius(8)
                                                                                    }
                                                                                }
                                                                            }
                                                                            .listStyle(InsetGroupedListStyle())

                                                                            Spacer()
                                                                        }
                                                                        .navigationBarItems(trailing: Button("Close", action: {
                                                                            viewModel.isShowingStore = false
                                                                        }))
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
            }
        }
    }
}
