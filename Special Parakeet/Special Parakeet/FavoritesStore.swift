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
    var firebaseDatabase: Firestore { get }
    var areFavorited: [IsFavorited] { get }
    func makeFavorite(_ documentMaker: IsFavoritedDocumentMaker) async
    func getFavorites() async
    func unFavorite(_ documentMaker: IsFavoritedDocumentMaker) async
}

struct BirdDocument: Decodable {
    let name: String
    let isFavorited: Bool
}

struct IsFavoritedDocumentMaker {
    let document: DocumentReference!
    let birdName: String
    let isFavorited: Bool
    let data: [String:Any]
    
    init(firebaseDatabase: Firestore,
         collectionPath: FirestoreCollection,
         birdName: String,
         isFavorited: Bool,
         data: [String:Any]) {
        self.document = firebaseDatabase.collection(collectionPath.rawValue).document(birdName)
        self.birdName = birdName
        self.isFavorited = isFavorited
        self.data = data
    }
}

enum FirestoreCollection: String {
    case isFavorited
}

class FavoritesStore: ObservableObject, FavoritesStoreProtocol {
    var areFavorited: [IsFavorited] = []
    
    @Environment(\.firebaseDatabase) var firebaseDatabase: Firestore
            
    init(settings: FirestoreSettings? = nil) {
        if let settings = settings {
            self.firebaseDatabase.settings = settings
        }
    }
    
    func makeFavorite(_ documentMaker: IsFavoritedDocumentMaker) async {
        if let document = documentMaker.document {
            do {
                try await document.setData(documentMaker.data)
            } catch {
                print("Error writing to \(documentMaker.birdName) document when setting isFavorite to true.")
            }
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
    
    func unFavorite(_ documentMaker: IsFavoritedDocumentMaker) async {
        if let unFavoriteDocument = documentMaker.document {
            do {
                try await unFavoriteDocument.setData(documentMaker.data)
            } catch {
                print("Error writing to \(documentMaker.birdName) document when setting isFavorited to false.")
            }
        }
    }
}
