//
//  BirdFavoritesView.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 19/01/2024.
//

import Foundation
import SwiftUI

struct BirdFavoritesView: View {
    let birds: [ Bird]
    
    var body: some View {
        List {
            ForEach(birds) { bird in
                HStack {
                    Image(systemName: "bird")
                    Spacer()
                    Text(bird.name)
                }
            }
        }.listStyle(.plain)
    }
}

#Preview {
    BirdFavoritesView(birds: [
        Bird(name: "Sparrow", family: "Some"),
        Bird(name: "Accipiter", family: "Some"),
        Bird(name: "Blue Jay", family: "Some")
    ])
}
