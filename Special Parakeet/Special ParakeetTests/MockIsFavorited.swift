//
//  MockIsFavorited.swift
//  Special ParakeetTests
//
//  Created by Asaad Jaber on 16/02/2024.
//

import Foundation
@testable import Special_Parakeet
import FirebaseFirestore
import SwiftUI

final class MockIsFavorited: ObservableObject {
    var bird: Bird
    
    @Environment(\.firebaseDatabase) var firebaseDatabase: Firestore
    
    var favoritesStore: FavoritesStoreProtocol
    
    var isFavorited: Bool {
        willSet {
            objectWillChange.send()
            Task { await changeFavorite(newValue) }
        }
    }
    
    var didCallMakeFavorite: Bool = false

    func changeFavorite(_ newValue: Bool) async {
        didCallMakeFavorite = newValue
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case isFavorited
    }
    
    init(name: String, family: String, 
         isFavorited: Bool,
         favoritesStore: FavoritesStoreProtocol) {
        self.bird = Bird(name: name, family: family)
        self.isFavorited = isFavorited
        self.favoritesStore = favoritesStore
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let birdName = try values.decode(String.self, forKey: CodingKeys.name)
        self.isFavorited = try values.decode(Bool.self, forKey: CodingKeys.isFavorited)
        self.bird = Bird(name: birdName, family: "")
        self.favoritesStore = MockFavoritesStore()
    }
}
