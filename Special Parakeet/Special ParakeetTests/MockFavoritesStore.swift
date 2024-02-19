//
//  MockFavoritesStore.swift
//  Special ParakeetTests
//
//  Created by Asaad Jaber on 26/01/2024.
//

import Foundation
import SwiftUI
@testable import Special_Parakeet
import FirebaseFirestore

final class MockFavoritesStore: FavoritesStoreProtocol {
    
    @Environment(\.firebaseDatabase) var firebaseDatabase: Firestore
        
<<<<<<< Updated upstream
    var areFavorited: [Special_Parakeet.IsFavorited] = []
    
    init(settings: FirestoreSettings) {
        self.firebaseDatabase = Firestore.firestore()
        self.firebaseDatabase.settings = settings
    }
    
    var makeFavoriteCollectionPath: String = ""
    var makeFavoriteDocumentPath: String = ""
    var makeFavoriteDocumentData: [String:Any] = [:]
    var makeFavoriteIsFavorited: Bool = false
    
    func makeFavorite(_ documentMaker: IsFavoritedDocumentMaker) async throws {
        makeFavoriteCollectionPath = documentMaker.document.parent.path
        makeFavoriteDocumentPath = documentMaker.document.path
        makeFavoriteDocumentData = documentMaker.data
        makeFavoriteIsFavorited = documentMaker.isFavorited
=======
    var areFavorited: [IsFavorited]!
        
    var changeFavoriteBirdName: String = ""
    var changeFavoriteCollectionPath: String = ""
    var changeFavoriteDocumentData: [String:Any] = [:]
    var changeFavoriteIsFavorited: Bool = false
    
    func changeFavorite(_ documentMaker: Special_Parakeet.IsFavoritedDocumentMaker) async throws {
        self.changeFavoriteBirdName = documentMaker.birdName
        self.changeFavoriteCollectionPath = documentMaker.collectionPath.rawValue
        self.changeFavoriteDocumentData = documentMaker.data
        self.changeFavoriteIsFavorited = documentMaker.isFavorited
>>>>>>> Stashed changes
    }
    
    var isFavoritedQueryFieldName: String = ""
    var isFavoritedQueryCollectionPath: String = ""
    var isFavoritedQueryFilterValue: Bool = true
    
    func getFavorites(_ queryMaker: IsFavoriteQueryMaker) async throws {
        self.isFavoritedQueryFieldName = queryMaker.fieldName
        self.isFavoritedQueryCollectionPath = queryMaker.collectionPath.rawValue
        self.isFavoritedQueryFilterValue = queryMaker.queryFilterValue
    }
}
