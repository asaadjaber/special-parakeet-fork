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
    
    func getFavorites() async {
        //TODO: Implement getFavorites() mock method body.
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
