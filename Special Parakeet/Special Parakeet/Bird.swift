//
//  Bird.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 19/12/2023.
//

import Foundation
import SwiftUI

class Bird: ObservableObject, Identifiable {
    let name: String
    let family: String
    
    @Published var isFavorited: Bool = false
    
    var id: String { name }
    
    init(name: String, family: String, isFavorited: Bool?) {
        self.name = name
        self.family = family
        if let isFavorited {
            self.isFavorited = isFavorited
        }
    }
}

extension Bird: Hashable {
    static func == (lhs: Bird, rhs: Bird) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
         hasher.combine(name)
     }
}
