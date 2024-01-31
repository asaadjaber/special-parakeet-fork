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
    func makeFavorite(_ documentMaker: IsFavoritedDocumentMaker) async throws
    func getFavorites(_ queryMaker: IsFavoriteQueryMaker) async throws
    func unFavorite(_ documentMaker: IsFavoritedDocumentMaker) async throws
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

enum GetError: String {
    case snapshotError = "Error getting snapshot."
}

enum SetError: String {
    case setIsFavoriteTrue = "Error setting isFavorite to true."
    case setIsFavoriteFalse = "Error settings isFavorite to false."
}

struct IsFavoritedSnapshot {
    let collectionPath: FavoritesStoreCollection
    var areFavorited: [IsFavorited] = []
    
    init(fromQuery query: Query, collectionPath: FavoritesStoreCollection) async {
        self.collectionPath = collectionPath
        do {
            try await getSnapshot(query: query)
        } catch {
            print(GetError.snapshotError.rawValue)
        }
    }

    private mutating func getSnapshot(query: Query) async throws {
        var isFavorited: [IsFavorited] = []
        let querySnapshot = try await query.getDocuments()
        
        let documents = querySnapshot.documents
        isFavorited = try documents.map({ try $0.data(as: IsFavorited.self )})
        
        areFavorited = isFavorited
    }
}

enum FavoritesStoreCollection: String {
    case isFavorited
}

class FavoritesStore: ObservableObject, FavoritesStoreProtocol {
    @Published var areFavorited: [IsFavorited] = []
    
    @Environment(\.firebaseDatabase) var firebaseDatabase: Firestore
            
    init(settings: FirestoreSettings? = nil) {
        if let settings = settings {
            self.firebaseDatabase.settings = settings
        }
    }
    
    func makeFavorite(_ documentMaker: IsFavoritedDocumentMaker) async throws {
        if let document = documentMaker.document {
            try await document.setData(documentMaker.data)
        }
    }
    
    func getFavorites(_ queryMaker: IsFavoriteQueryMaker) async throws {
        let query = queryMaker.query
        let isFavoritedDocumentsSnapshot = await IsFavoritedSnapshot(fromQuery: query,
                                                               collectionPath: queryMaker.collectionPath)
        areFavorited = isFavoritedDocumentsSnapshot.areFavorited
    }
    
    func unFavorite(_ documentMaker: IsFavoritedDocumentMaker) async throws {
        if let unFavoriteDocument = documentMaker.document {
            try await unFavoriteDocument.setData(documentMaker.data)
        }
    }
}
