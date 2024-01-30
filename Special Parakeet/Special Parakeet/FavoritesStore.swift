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
    func getFavorites(_ queryMaker: IsFavoriteQueryMaker) async
    func unFavorite(_ documentMaker: IsFavoritedDocumentMaker) async
}

struct IsFavoritedDocumentMaker {
    let document: DocumentReference!
    let birdName: String
    let isFavorited: Bool
    let data: [String:Any]
    
    init(firebaseDatabase: Firestore,
         collectionPath: FavoritesStoreCollection,
         birdName: String,
         isFavorited: Bool,
         data: [String:Any]) {
        self.document = firebaseDatabase.collection(collectionPath.rawValue).document(birdName)
        self.birdName = birdName
        self.isFavorited = isFavorited
        self.data = data
    }
}

struct IsFavoriteQueryMaker {
    let query: Query
    let collectionPath: FavoritesStoreCollection
    let fieldName: String
    let queryFilterValue: Bool
    
    init(firebaseDatabase: Firestore, 
         fieldName: String,
         collectionPath: FavoritesStoreCollection,
         queryFilterValue value: Bool) {
        self.fieldName = fieldName
        self.queryFilterValue = value
        self.collectionPath = collectionPath
        self.query = firebaseDatabase.collection(collectionPath.rawValue)
                        .whereField(fieldName, isEqualTo: queryFilterValue)
    }
}

enum FavoritesStoreCollection: String {
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
    
    func getFavorites(_ queryMaker: IsFavoriteQueryMaker) async {
        do {
            let isFavoritedSnapshot = try await firebaseDatabase.collection("isFavorited").whereField("isFavorited", isEqualTo: true).getDocuments()
            isFavoritedSnapshot.documents.forEach { snapshot in
                do {
                    let data = try snapshot.data(as: IsFavorited.self)
                    if data.isFavorited {
                        areFavorited.append(data)
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
