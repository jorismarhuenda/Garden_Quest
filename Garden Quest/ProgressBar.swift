//
//  ProgressBar.swift
//  Garden Quest
//
//  Created by marhuenda joris on 06/08/2023.
//

import SwiftUI

// MARK: - ProgressBar
struct ProgressBar: View {
    var progress: Double
    var total: Double

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.gray)
                    .frame(width: geometry.size.width, height: geometry.size.height)

                Rectangle()
                    .foregroundColor(Color.blue)
                    .frame(width: min(CGFloat(self.progress / self.total) * geometry.size.width, geometry.size.width), height: geometry.size.height)
            }
        }
        .cornerRadius(10.0)
    }
}
