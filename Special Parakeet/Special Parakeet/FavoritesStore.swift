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
    var firebaseDatabase: Firestore? { get }
    var areFavorited: [IsFavorited] { get }
    func getFavorites(_ queryMaker: IsFavoriteQueryMaker) async throws
    func changeFavorite(_ documentMaker: IsFavoritedDocumentMaker) async throws
}

struct IsFavoritedDocumentMaker {
    let birdName: String
    let collectionPath: FavoritesStoreCollection
    let isFavorited: Bool
    var data: [String:Any] {
        ["name": birdName,
        "isFavorited": isFavorited]
    }
    
    init(collectionPath: FavoritesStoreCollection,
         birdName: String,
         isFavorited: Bool) {
        self.collectionPath = collectionPath
        self.birdName = birdName
        self.isFavorited = isFavorited
    }
}

struct IsFavoriteQueryMaker {
    let collectionPath: FavoritesStoreCollection
    let fieldName: String
    let queryFilterValue: Bool
    
    init(fieldName: String,
         collectionPath: FavoritesStoreCollection,
         queryFilterValue value: Bool) {
        self.fieldName = fieldName
        self.queryFilterValue = value
        self.collectionPath = collectionPath
    }
}

enum FavoritesStoreCollection: String {
    case isFavorited
}

enum QuerySnapshotError: Error {
    case queryIsNilError
}

enum FirebaseChangeFavoriteError: Error {
    case documentError
}

class FavoritesStore: ObservableObject, FavoritesStoreProtocol {
    @Published var areFavorited: [IsFavorited]
    
    var firebaseDatabase: Firestore?
            
    init(firebaseDatabase: Firestore?,
         areFavorited: [IsFavorited]? = nil) {
        if areFavorited == nil {
            self.areFavorited = []
        } else {
            self.areFavorited = areFavorited!
        }
        self.firebaseDatabase = firebaseDatabase
    }
        
    func getFavorites(_ queryMaker: IsFavoriteQueryMaker) async throws {
        let query = firebaseDatabase?.collection(queryMaker.collectionPath.rawValue)
                        .whereField(queryMaker.fieldName, isEqualTo: queryMaker.queryFilterValue)
        guard let query = query else { throw QuerySnapshotError.queryIsNilError }
        let querySnapshot = try await query.getDocuments()
        let documentSnapshots = querySnapshot.documents
        var areFavorited: [IsFavorited] = []
        for documentSnapshot in documentSnapshots {
            do {
                let isFavorited = try documentSnapshot.data(as: IsFavorited.self)
                areFavorited.append(isFavorited)
            } catch {
                print("error decoding data from document: \(error.localizedDescription)")
            }
        }
        self.areFavorited = areFavorited
    }
    
    func changeFavorite(_ documentMaker: IsFavoritedDocumentMaker) async throws {
        guard let document = firebaseDatabase?.collection(documentMaker.collectionPath.rawValue).document(documentMaker.birdName) else { throw FirebaseChangeFavoriteError.documentError }
        do {
            try await document.setData(documentMaker.data)
        } catch {
            throw error
        }
    }
}
