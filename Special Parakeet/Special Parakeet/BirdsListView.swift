//
//  BirdsListView.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 19/12/2023.
//

import Foundation
import SwiftUI

struct BirdsListView: View {
    @State private var presentedBirds: [Bird] = []
    @EnvironmentObject var favoritesStore: FavoritesStore
    
    let birds: [Bird] = [
        Bird(name: "Sparrow", family: "Some"),
        Bird(name: "Eagle", family: "Some"),
        Bird(name: "Crow", family: "Some"),
        Bird(name: "Blue Jay", family: "Some")
    ]
    
    let columns = [GridItem(.adaptive(minimum: 70, maximum: 100))]
    
    var body: some View {
        NavigationStack(path: $presentedBirds) {
            LazyVGrid(columns: columns) {
                ForEach(birds) { bird in
                    BirdStackView(bird: bird, presentedBirds: $presentedBirds)
                }
            }.padding(EdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 13))
            .navigationDestination(for: Bird.self) { bird in
                BirdDetailView(bird: bird, favoritesStore: favoritesStore)
            }
        }
    }
}

#Preview {
    BirdsListView().environmentObject(FavoritesStore(firebaseDatabase: nil))
}
