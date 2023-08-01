//
//  Garden_QuestApp.swift
//  Garden Quest
//
//  Created by marhuenda joris on 01/08/2023.
//

import SwiftUI

@main
struct Garden_QuestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
