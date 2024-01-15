//
//  BirdDetailView.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 27/12/2023.
//

import Foundation
import SwiftUI

struct BirdDetailView: View {
    @StateObject var isFavorited: IsFavorited
    
    var body: some View {
        List {
            Section(content: {
                BirdDetailFavoriteButtonView(isFavorited: isFavorited)
                VStack(alignment: .leading) {
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
    BirdDetailView(isFavorited: IsFavorited(name: "Sparrow", family: "Some", isFavorited: true))
}
