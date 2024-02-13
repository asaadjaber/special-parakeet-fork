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
    
    init(_ bird: Bird) {
        _isFavorited = StateObject(wrappedValue: IsFavorited(name: bird.name,
                                                             family: bird.family,
                                                             isFavorited: false))
    }
    
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
    BirdDetailView(Bird(name: "Sparrow", family: "Some"))
}
