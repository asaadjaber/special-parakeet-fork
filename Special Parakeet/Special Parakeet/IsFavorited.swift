//
//  IsFavorited.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 15/01/2024.
//

import Foundation

class IsFavorited: ObservableObject, Decodable  {
    let bird: Bird
    @Published var isFavorited: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case name
        case isFavorited
    }
    
    init(name: String, family: String, isFavorited: Bool) {
        self.bird = Bird(name: name, family: family)
        self.isFavorited = isFavorited
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let birdName = try values.decode(String.self, forKey: CodingKeys.name)
        self.isFavorited = try values.decode(Bool.self, forKey: CodingKeys.isFavorited)
        self.bird = Bird(name: birdName, family: "")
    }
}
