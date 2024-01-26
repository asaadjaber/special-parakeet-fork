//
//  FavoritesStoreUnitTests.swift
//  Special ParakeetTests
//
//  Created by Asaad Jaber on 20/01/2024.
//

import XCTest
@testable import Special_Parakeet
import FirebaseFirestore

final class FavoritesStoreUnitTests: XCTestCase {

    var mockFavoritesStore: MockFavoritesStore!
    var firebaseDatabase: Firestore!
    
    override func setUpWithError() throws {
        mockFavoritesStore = MockFavoritesStore(settings: FirestoreEmulatorSettings().settings)
        firebaseDatabase = mockFavoritesStore.firebaseDatabase
    }
    
    func testMakeFavoriteMethod() async {
        
        let collectionPath = FirestoreCollection.isFavorited
        let documentPath = "isFavorited/Sparrow"
        let birdName = "Sparrow"
        let isFavorited = true
        let data: [String : Any] = [
            "name": birdName,
            "isFavorited": isFavorited
        ]
        
        let IsFavoritedDocumentMaker = IsFavoritedDocumentMaker(firebaseDatabase: firebaseDatabase,
                                                                  collectionPath: collectionPath,
                                                                  birdName: birdName,
                                                                  isFavorited: isFavorited,
                                                                  data: data)
        
        await mockFavoritesStore.makeFavorite(IsFavoritedDocumentMaker)
        
        XCTAssertEqual(mockFavoritesStore.makeFavoriteCollectionPath, collectionPath.rawValue)
        XCTAssertEqual(mockFavoritesStore.makeFavoriteDocumentPath, documentPath)
        XCTAssertEqual(mockFavoritesStore.makeFavoriteDocumentData as NSDictionary, data as NSDictionary)
        XCTAssertEqual(mockFavoritesStore.makeFavoriteIsFavorited, isFavorited)
    }
    
    func testGetFavoritesMethod() {
        print("getFavorites")
    }
    
    func testUnfavoriteMethod() async {
        
        let collectionPath = FirestoreCollection.isFavorited
        let documentPath = "isFavorited/Sparrow"
        let birdName = "Sparrow"
        let isFavorited = false
        let data: [String : Any] = [
            "name": birdName,
            "isFavorited": isFavorited
        ]
        
        let IsFavoritedDocumentMaker = IsFavoritedDocumentMaker(firebaseDatabase: firebaseDatabase,
                                                                  collectionPath: collectionPath,
                                                                  birdName: birdName,
                                                                  isFavorited: isFavorited,
                                                                  data: data)
        
        await mockFavoritesStore.unFavorite(IsFavoritedDocumentMaker)
        
        XCTAssertEqual(mockFavoritesStore.unFavoriteCollectionPath, collectionPath.rawValue)
        XCTAssertEqual(mockFavoritesStore.unFavoriteDocumentPath, documentPath)
        XCTAssertEqual(mockFavoritesStore.unFavoriteDocumentData as NSDictionary, data as NSDictionary)
        XCTAssertEqual(mockFavoritesStore.unFavoritedIsFavorited, isFavorited)
    }
}
