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
    var areFavorited: [IsFavorited]! { get }
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

struct IsFavoritedSnapshot {
    let collectionPath: FavoritesStoreCollection
    var isFavoritedDocuments: [QueryDocumentSnapshot] = []
    
    init(fromQuery query: Query, collectionPath: FavoritesStoreCollection) async {
        self.collectionPath = collectionPath
        await getDocuments(query: query, collectionPath: collectionPath)
    }

    private mutating func getDocuments(query: Query, collectionPath: FavoritesStoreCollection) async {
        do {
            let querySnapshot = try await query.getDocuments()
            let documents = querySnapshot.documents
            isFavoritedDocuments = documents
        } catch {
            print("Unable to get snapshot for \(collectionPath.rawValue) collection: \(error.localizedDescription)")
        }
    }
}

enum FavoritesStoreCollection: String {
    case isFavorited
}

class FavoritesStore: ObservableObject, FavoritesStoreProtocol {
    @Published var areFavorited: [IsFavorited]!
    
    @Environment(\.firebaseDatabase) var firebaseDatabase: Firestore
            
    init(settings: FirestoreSettings? = nil,
         areFavorited: [IsFavorited]? = nil) {
        if areFavorited == nil {
            self.areFavorited = []
        } else {
            self.areFavorited = areFavorited!
        }
        if let settings = settings {
            self.firebaseDatabase.settings = settings
        }
    }
    
    func makeFavorite(_ documentMaker: IsFavoritedDocumentMaker) async {
        if let document = documentMaker.document {
            do {
                try await document.setData(documentMaker.data)
            } catch {
                print("Unable to set data for \(documentMaker.birdName) document: \(error.localizedDescription)")
            }
        }
    }
    
    func getFavorites(_ queryMaker: IsFavoriteQueryMaker) async throws {
        let query = queryMaker.query
        let isFavoritedDocumentsSnapshot = await IsFavoritedSnapshot(fromQuery: query,
                                                               collectionPath: queryMaker.collectionPath)
        let documents = isFavoritedDocumentsSnapshot.isFavoritedDocuments
        areFavorited = try documents.map({ try $0.data(as: IsFavorited.self )})
    }
    
    func unFavorite(_ documentMaker: IsFavoritedDocumentMaker) async {
        if let unFavoriteDocument = documentMaker.document {
            do {
                try await unFavoriteDocument.setData(documentMaker.data)
            } catch {
                print("Unable to set data for \(documentMaker.birdName) document: \(error.localizedDescription)")
            }
        }
    }
}
