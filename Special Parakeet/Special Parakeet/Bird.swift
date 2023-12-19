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
    
    @Published var isFlipped: Bool = false
    
    var id: String { name }
    
    init(name: String, isFlipped: Bool?) {
        self.name = name
        if let isFlipped {
            self.isFlipped = isFlipped
        }
    }
}
