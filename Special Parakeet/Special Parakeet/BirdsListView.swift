//
//  BirdsListView.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 19/12/2023.
//

import Foundation
import SwiftUI

struct BirdsListView: View {
    let columns = [GridItem(.adaptive(minimum: 70, maximum: 100))]

    var birds = [
        Bird(name: "Accipiter", isFlipped: false),
        Bird(name: "Eagle", isFlipped: false),
        Bird(name: "Sparrow", isFlipped: false),
        Bird(name: "Pigeon", isFlipped: false),
        Bird(name: "Crow", isFlipped: false),
        Bird(name: "BlueJay", isFlipped: false),
        Bird(name: "Woodpecker", isFlipped: false)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(birds) { bird in
                BirdStackView(bird: bird)
            }
        }.padding(EdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 13))
    }
}

#Preview {
    BirdsListView()
}
