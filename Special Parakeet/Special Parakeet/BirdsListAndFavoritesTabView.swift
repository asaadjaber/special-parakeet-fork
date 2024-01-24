//
//  BirdsListAndFavoritesTabView.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 19/01/2024.
//

import Foundation
import SwiftUI
import FirebaseFirestore

struct BirdsListAndFavoritesTabView: View {
    @Binding var presentedBirds: [Bird]
    var birds: [Bird]
    
    var body: some View {
        TabView {
            BirdsListView(presentedBirds: $presentedBirds, birds: birds).tabItem {
                Label("Birds", systemImage: "bird.circle.fill")
            }
            BirdFavoritesView(favoritesStore: FavoritesStore(), birds: birds).tabItem {
                Label("Favorited Birds", systemImage: "heart.circle.fill")
            }
        }
    }
}

#Preview {
    BirdsListAndFavoritesTabView(presentedBirds: Binding(projectedValue: .constant([])), birds: [
        Bird(name: "Sparrow", family: "Some"),
        Bird(name: "Eagle", family: "Some"),
        Bird(name: "Crow", family: "Some"),
        Bird(name: "Blue Jay", family: "Some")
    ])
}
