//
//  BirdDetailFavoriteButtonView.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 10/01/2024.
//

import Foundation
import SwiftUI

struct BirdDetailFavoriteButtonView: View {
    @ObservedObject var isFavorited: IsFavorited
    
    var body: some View {
        Label(
            title: { Text(isFavorited.bird.name) },
            icon: {
                Button {
                    withAnimation {
                        isFavorited.isFavorited.toggle()
                    }
                } label: {
                    Image(systemName: isFavorited.isFavorited ? "heart.circle.fill" : "heart.circle")
                }}).font(.title)
            .fontWeight(.heavy)
    }
}

#Preview {
    BirdDetailFavoriteButtonView(isFavorited: IsFavorited(name: "Sparrow",
                                                          family: "Some",
                                                          isFavorited: true))
}
