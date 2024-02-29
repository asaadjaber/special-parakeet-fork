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
    case querySnapshotError
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
        
        do {
            let querySnapshot = try await query?.getDocuments()
            guard let documents = querySnapshot?.documents else { throw  QuerySnapshotError.querySnapshotError }
            areFavorited = try documents.map({ try $0.data(as: IsFavorited.self )}) as! [IsFavorited]
        } catch {
            print("Unable to get snapshot for \(queryMaker.collectionPath.rawValue) collection: \(error.localizedDescription)")
        }
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
