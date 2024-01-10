//
//  BirdDetailView.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 27/12/2023.
//

import Foundation
import SwiftUI

struct BirdDetailView: View {
    @ObservedObject var bird: Bird
    
    var body: some View {
        List {
            Section(content: {
                VStack(alignment: .leading) {
                    HStack {
                        BirdDetailFavoriteButtonView(bird: bird)
                    }
                    Text("Bird Family")
                        .fontWeight(.heavy)
                        .foregroundStyle(.gray)
                }
            }, header: {
                Image(systemName: "camera.macro")
                    .resizable()
                    .aspectRatio(1.67, contentMode: .fit)
            })
            Section("Description") {
                Text("Lorem ipsum")
            }
        }
        .listRowSeparator(.hidden, edges: .all)
        .listStyle(.plain)
    }
}

#Preview {
    BirdDetailView(bird: Bird(name: "Sparrow", family: "Some", isFavorited: true))
}
