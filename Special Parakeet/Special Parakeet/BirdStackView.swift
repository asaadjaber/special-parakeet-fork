//
//  BirdStackView.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 22/12/2023.
//

import Foundation
import SwiftUI

struct BirdStackView: View {
    var bird: Bird
    @Binding var presentedBirds: [Bird]
    
    var body: some View {
        VStack(alignment: .center) {
            ZStack(alignment: .topTrailing) {
                Button(action: tapInfoButton) {
                    Image(systemName: "info")
                }
                Image(uiImage: .checkmark)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
            }.padding(EdgeInsets(top: 0, leading: 15, bottom: -30, trailing: 15))
                .frame(width: 100, height: 100)
            Button(action: {
                presentedBirds.append(bird)
            }, label: {
                Text(bird.name)
            }).buttonStyle(.borderedProminent)
                .lineLimit(1)
                .accessibilityIdentifier("birdButton")
        }
    }
    
    func tapInfoButton() {
        // Place tap info button logic here.
    }
}

#Preview {
    BirdStackView(bird: Bird(name: "Sparrow", family: "Some"),
                  presentedBirds: Binding(projectedValue: .constant([])))
}
