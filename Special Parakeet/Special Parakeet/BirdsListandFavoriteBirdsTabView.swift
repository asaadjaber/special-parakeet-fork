//
//  BirdsListandFavoriteBirdsTabView.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 15/11/2023.
//

import SwiftUI

struct BirdsListandFavoriteBirdsTabView: View {
    
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
        TabView {
            BirdsListView().tabItem {
                Label("Birds", systemImage: "bird.circle.fill")
            }
            FavoriteBirdsView().tabItem {
                Label("Favorite Birds", systemImage: "heart.circle.fill")
            }
        }
    }
}

#Preview {
    BirdsListandFavoriteBirdsTabView().environmentObject(FavoritesStore(firebaseDatabase: nil, areFavorited: [
        IsFavorited(name: "Heron", family: "", isFavorited: true, favoritesStore: FavoritesStore(firebaseDatabase: nil)),
        IsFavorited(name: "Lark", family: "", isFavorited: false, favoritesStore: FavoritesStore(firebaseDatabase: nil)),
        IsFavorited(name: "Magpie", family: "", isFavorited: true, favoritesStore: FavoritesStore(firebaseDatabase: nil)),
        IsFavorited(name: "Starling", family: "", isFavorited: true, favoritesStore: FavoritesStore(firebaseDatabase: nil)),
        IsFavorited(name: "Kingfisher", family: "", isFavorited: true, favoritesStore: FavoritesStore(firebaseDatabase: nil))
    ]))
}
