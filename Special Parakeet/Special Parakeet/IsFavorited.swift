//
//  IsFavorited.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 15/01/2024.
//

import Foundation

class IsFavorited: ObservableObject  {
    let bird: Bird
    @Published var isFavorited: Bool = false
    
    init(name: String, family: String, isFavorited: Bool) {
        self.bird = Bird(name: name, family: family)
        self.isFavorited = isFavorited
    }
}
