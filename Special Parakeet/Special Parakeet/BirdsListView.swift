//
//  BirdsListView.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 19/12/2023.
//

import Foundation
import SwiftUI

struct BirdsListView: View {
    @Binding var presentedBirds: [Bird]
    @EnvironmentObject var favoritesStore: FavoritesStore
    @StateObject var birdsAPI: BirdsAPI = BirdsAPI()
    
    let columns = [GridItem(.adaptive(minimum: 70, maximum: 100))]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(birdsAPI.birdResults) { birdResult in
                    BirdStackView(bird: Bird(name: birdResult.speciesGuess ?? " ", family: ""), presentedBirds: $presentedBirds)
                }
            }.padding(EdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 13))
            .navigationDestination(for: Bird.self) { bird in
                BirdDetailView(bird: bird, isFavorited: favoritesStore.findIsFavorited(bird.name), favoritesStore: favoritesStore)
            }
        }.onAppear {
            birdsAPI.fetchObservations()
        }
    }
}

#Preview {
    BirdsListView(presentedBirds: Binding(projectedValue: .constant([Bird(name: "Sparrow", family: "some")]) )).environmentObject(FavoritesStore(firebaseDatabase: nil))
}
