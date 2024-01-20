//
//  FavoritesStore.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 12/01/2024.
//

import Foundation
import SwiftUI
import FirebaseFirestore

protocol FavoritesStoreProtocol {
    func makeFavorite(birdName: String) async
    func getFavorites()
    func unFavorite(birdName: String)
}

class FavoritesStore: ObservableObject, FavoritesStoreProtocol {
    
    @Environment(\.firebaseDatabase) var firebaseDatabase: Firestore
    
    func makeFavorite(birdName: String) async {
        do {
            try await firebaseDatabase.collection("isFavorited").document("\(birdName)").setData([
                "name": birdName,
                "isFavorited": true
            ])
        } catch {
            print("Error writing to birdName document")
        }
    }
    
    func getFavorites() {
        //
    }
    
    func unFavorite(birdName: String) {
        //
    }
}
