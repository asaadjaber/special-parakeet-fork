//
//  Bird.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 19/12/2023.
//

import Foundation
import SwiftUI

struct Bird: Identifiable {
    let name: String
    let family: String
    var id: String { name }
}

extension Bird: Hashable {
    static func == (lhs: Bird, rhs: Bird) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
         hasher.combine(name)
     }
}
