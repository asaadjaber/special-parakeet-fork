//
//  IsFavorited.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 15/01/2024.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseFirestore

class IsFavorited: ObservableObject, Decodable  {
    var bird: Bird
    var favoritesStore: FavoritesStore?
        
    var isFavorited: Bool = false {
        willSet {
            objectWillChange.send()
            Task { await makeFavorite(newValue) }
        }
    }
            
    private enum CodingKeys: String, CodingKey {
        case name
        case isFavorited
    }
    
    init(name: String, 
         family: String,
         isFavorited: Bool,
         favoritesStore: FavoritesStore?) {
        self.bird = Bird(name: name, family: family)
        self.isFavorited = isFavorited
        self.favoritesStore = favoritesStore
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let birdName = try values.decode(String.self, forKey: CodingKeys.name)
        self.isFavorited = try values.decode(Bool.self, forKey: CodingKeys.isFavorited)
        self.bird = Bird(name: birdName, family: "")
    }

    @MainActor
    func makeFavorite(_ isFavorited: Bool) async {
        do {
            try await favoritesStore?.changeFavorite(IsFavoritedDocumentMaker(collectionPath: FavoritesStoreCollection.isFavorited,
                                                                                 birdName: bird.name,
                                                                                 isFavorited: isFavorited))
        } catch {
            print("Unable to set data for \(bird.name) document: \(error.localizedDescription)")
        }
    }
}

extension IsFavorited: Identifiable, Hashable {
    var id: String {
        UUID().uuidString
    }

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    static func == (lhs: IsFavorited, rhs: IsFavorited) -> Bool {
        lhs.id == rhs.id
    }
}

