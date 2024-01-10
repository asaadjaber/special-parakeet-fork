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
                    Text("Bird Family")
                    Text("Description")
                    Text("Lorem ipsum")
                }
            }, header: {
                Image(systemName: "camera.macro")
                    .resizable()
                    .aspectRatio(1.67, contentMode: .fit)
            })
        }
        .listRowSeparator(.hidden, edges: .all)
        .listStyle(.plain)
    }
        
    func birdAction() {
        bird.isFavorited.toggle()
    }
}

#Preview {
    BirdDetailView(bird: Bird(name: "Sparrow", family: "Some", isFavorited: true))
}
