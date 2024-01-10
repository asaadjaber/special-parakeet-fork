//
//  BirdDetailFavoriteButtonView.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 10/01/2024.
//

import Foundation
import SwiftUI

struct BirdDetailFavoriteButtonView: View {
    @ObservedObject var bird: Bird
    
    var body: some View {
        HStack {
            if bird.isFavorited {
                Button(action: birdAction, label: {
                    Text(bird.name)
                        .fontWeight(.black)
                        .font(.title2)
                }).buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .accessibilityIdentifier("birdDetailViewBirdNameText")
            } else {
                Button(action: birdAction, label: {
                    Text(bird.name)
                        .fontWeight(.heavy)
                        .font(.title2)
                }).buttonStyle(.bordered)
                    .controlSize(.large)
                    .accessibilityIdentifier("birdDetailViewBirdNameText")
            }
        }
    }
    
    func birdAction() {
        bird.isFavorited.toggle()
    }
}

#Preview {
    BirdDetailFavoriteButtonView(bird: Bird(name: "Sparrow", family: "Some", isFavorited: false))
}
