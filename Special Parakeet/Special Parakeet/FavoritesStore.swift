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
    var areFavorited: [IsFavorited] { get }
    func makeFavorite(birdName: String) async
    func getFavorites() async
    func unFavorite(birdName: String) async
}

struct BirdDocument: Decodable {
    let name: String
    let isFavorited: Bool
}

class FavoritesStore: ObservableObject, FavoritesStoreProtocol {
    var areFavorited: [IsFavorited] = []
    
    @Environment(\.firebaseDatabase) var firebaseDatabase: Firestore
    
    func makeFavorite(birdName: String) async {
        do {
            try await firebaseDatabase.collection("isFavorited").document("\(birdName)").setData([
                "name": birdName,
                "isFavorited": true
            ])
        } catch {
            print("Error writing to birdName document.")
        }
    }
    
    func getFavorites() async {
        do {
            let isFavoritedSnapshot = try await firebaseDatabase.collection("isFavorited").whereField("isFavorited", isEqualTo: true).getDocuments()
            isFavoritedSnapshot.documents.forEach { snapshot in
                do {
                    let data = try snapshot.data(as: BirdDocument.self)
                    if data.isFavorited {
                        areFavorited.append(IsFavorited(name: data.name, 
                                                        family: "",
                                                        isFavorited: data.isFavorited))
                    }
                } catch {
                    print("Error decoding snapshot data.")
                }
            }
        } catch {
            print("Error getting isFavorited documents from Firestore.")
        }
    }
    
    func unFavorite(birdName: String) async {
        do {
            try await firebaseDatabase.collection("isFavorited").document("\(birdName)").setData([
                "name": birdName,
                "isFavorited": false
            ])
        } catch {
            print("Error writing to \(birdName) document when setting isFavorited to false.")
        }
    }
}
