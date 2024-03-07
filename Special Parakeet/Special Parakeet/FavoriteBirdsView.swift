//
//  FavoriteBirdsView.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 19/01/2024.
//

import Foundation
import SwiftUI
import FirebaseFirestore

struct FavoriteBirdsView: View {
    @EnvironmentObject var favoritesStore: FavoritesStore
    @Binding var presentedBirds: [Bird]
    
    var body: some View {
        NavigationStack(path: $presentedBirds) {
            List {
                ForEach(favoritesStore.filterAreFavorited()) { isFavorited in
                    HStack {
                        Image(systemName: "bird")
                        Spacer()
                        Text(isFavorited.bird.name)
                    }.onTapGesture {
                        presentedBirds.append(Bird(name: isFavorited.bird.name, family: isFavorited.bird.family))
                    }
                }
            }.listStyle(.plain)
                .navigationDestination(for: Bird.self) { bird in
                    BirdDetailView(bird: bird, isFavorited: favoritesStore.findIsFavorited(bird.name), favoritesStore: favoritesStore)
                }
        }
    }
}

#Preview {
    FavoriteBirdsView(presentedBirds: Binding(projectedValue: .constant([Bird(name: "Sparrow", family: "some")]))).environmentObject(FavoritesStore(firebaseDatabase: Firestore.firestore(), areFavorited: [
        IsFavorited(name: "Magpie", family: "", isFavorited: true, favoritesStore: FavoritesStore(firebaseDatabase: nil)),
        IsFavorited(name: "Pigeon", family: "", isFavorited: false, favoritesStore: FavoritesStore(firebaseDatabase: nil)),
        IsFavorited(name: "Chicken", family: "", isFavorited: true, favoritesStore: FavoritesStore(firebaseDatabase: nil))
    ]))
}
