//
//  ShopItem.swift
//  Garden Quest
//
//  Created by marhuenda joris on 06/08/2023.
//

import SwiftUI

// MARK: - ShopCategory
enum ShopCategory: String, CaseIterable {
    case seed
    case item
}

// MARK: - ShopItem
struct ShopItem: Identifiable {
    let id = UUID()
    let name: String
    let price: Int
    let category: ShopCategory
}
