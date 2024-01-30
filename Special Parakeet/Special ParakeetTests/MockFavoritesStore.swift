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
    var firebaseDatabase: Firestore
        
    var areFavorited: [Special_Parakeet.IsFavorited] = []
    
    init(settings: FirestoreSettings) {
        self.firebaseDatabase = Firestore.firestore()
        self.firebaseDatabase.settings = settings
    }
    
    var makeFavoriteCollectionPath: String = ""
    var makeFavoriteDocumentPath: String = ""
    var makeFavoriteDocumentData: [String:Any] = [:]
    var makeFavoriteIsFavorited: Bool = false
    
    func makeFavorite(_ documentMaker: IsFavoritedDocumentMaker) async {
        makeFavoriteCollectionPath = documentMaker.document.parent.path
        makeFavoriteDocumentPath = documentMaker.document.path
        makeFavoriteDocumentData = documentMaker.data
        makeFavoriteIsFavorited = documentMaker.isFavorited
    }
    
    var isFavoritedQueryFieldName: String = ""
    var isFavoritedQueryCollectionPath: String = ""
    var isFavoritedQueryFilterValue: Bool = true
    
    func getFavorites(_ queryMaker: IsFavoriteQueryMaker) async {
        self.isFavoritedQueryFieldName = queryMaker.fieldName
        self.isFavoritedQueryCollectionPath = queryMaker.collectionPath.rawValue
        self.isFavoritedQueryFilterValue = queryMaker.queryFilterValue
    }
    
    var unFavoriteCollectionPath: String = ""
    var unFavoriteDocumentPath: String = ""
    var unFavoriteDocumentData: [String:Any] = [:]
    var unFavoritedIsFavorited: Bool = true
    
    func unFavorite(_ documentMaker: IsFavoritedDocumentMaker) async {
        unFavoriteCollectionPath = documentMaker.document.parent.path
        unFavoriteDocumentPath = documentMaker.document.path
        unFavoriteDocumentData = documentMaker.data
        unFavoritedIsFavorited = documentMaker.isFavorited
    }
}
