//
//  BirdsListandFavoriteBirdsTabView.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 15/11/2023.
//

import SwiftUI

struct BirdsListandFavoriteBirdsTabView: View {
    @State var presentedBirds: [Bird] = []
    
    var body: some View {
        NavigationStack(path: $presentedBirds) {
            TabView {
                BirdsListView(presentedBirds: $presentedBirds).tabItem {
                    Label("Birds", systemImage: "bird.circle.fill")
                }
                FavoriteBirdsView().tabItem {
                    Label("Favorite Birds", systemImage: "heart.circle.fill")
                }
            }
        }
    }
}

#Preview {
    BirdsListandFavoriteBirdsTabView().environmentObject(FavoritesStore(firebaseDatabase: nil))
}
