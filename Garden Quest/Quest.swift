//
//  Quest.swift
//  Garden Quest
//
//  Created by marhuenda joris on 06/08/2023.
//

import SwiftUI

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
