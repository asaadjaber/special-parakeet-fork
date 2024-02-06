//
//  BirdsListandFavoriteBirdsTabView.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 15/11/2023.
//

import SwiftUI

struct BirdsListandFavoriteBirdsTabView: View {
    @State private var presentedBirds: [Bird] = []
    
    var birds = [
        Bird(name: "Accipiter", family: "Some"),
        Bird(name: "Eagle", family: "Some"),
        Bird(name: "Tree Sparrow", family: "Some"),
        Bird(name: "Pigeon", family: "Some"),
        Bird(name: "Crow", family: "Some"),
        Bird(name: "BlueJay", family: "Some"),
        Bird(name: "Woodpecker", family: "some")
    ]
    
    var body: some View {
        NavigationStack(path: $presentedBirds) {
            TabView {
                BirdsListView(presentedBirds: $presentedBirds).tabItem {
                    Label("Birds", systemImage: "bird.circle.fill")
                }
                BirdFavoritesView().tabItem {
                    Label("Favorite Birds", systemImage: "heart.circle.fill")
                }
            }
        }
    }
}

#Preview {
    BirdsListandFavoriteBirdsTabView()
}
