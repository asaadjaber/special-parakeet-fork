//
//  BirdsListandFavoriteBirdsTabView.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 15/11/2023.
//

import SwiftUI

struct BirdsListandFavoriteBirdsTabView: View {
        
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
    BirdsListandFavoriteBirdsTabView().environmentObject(FavoritesStore(firebaseDatabase: nil))
}
