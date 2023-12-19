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
                Button(action: {
                    bird.isFlipped.toggle()
                }, label: {
                    Text(bird.name)
                })
            }.buttonStyle(.borderedProminent)
                .lineLimit(1)
        }
    }
}

#Preview {
    BirdsListView()
}
