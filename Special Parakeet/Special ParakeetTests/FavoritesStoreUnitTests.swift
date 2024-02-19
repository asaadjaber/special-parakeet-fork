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
    
    override func setUpWithError() throws {
        mockFavoritesStore = MockFavoritesStore()
    }
    
    func testMakeFavoriteChangeFavoriteMethod() async throws {
        
        let collectionPath = FavoritesStoreCollection.isFavorited
        let birdName = "Sparrow"
        let isFavorited = true
        
        let makeFavoriteDocumentMaker = IsFavoritedDocumentMaker(collectionPath: collectionPath,
                                                                  birdName: birdName,
                                                                  isFavorited: isFavorited)

        try await mockFavoritesStore.changeFavorite(makeFavoriteDocumentMaker)

        XCTAssertEqual(mockFavoritesStore.changeFavoriteBirdName, birdName)
        XCTAssertEqual(mockFavoritesStore.changeFavoriteCollectionPath, collectionPath.rawValue)
        XCTAssertEqual(mockFavoritesStore.changeFavoriteIsFavorited, isFavorited)
        XCTAssertEqual(mockFavoritesStore.changeFavoriteDocumentData as NSDictionary, makeFavoriteDocumentMaker.data as NSDictionary)
    }
    
    func testGetFavoritesMethod() async throws {
        
        let fieldName = "isFavorited"
        let fieldQueryValue = false
        let collectionPath = FavoritesStoreCollection.isFavorited
        
        let isFavoritedQueryMaker = IsFavoriteQueryMaker(fieldName: fieldName,
                                                         collectionPath: collectionPath,
                                                         queryFilterValue: fieldQueryValue)
        
        try await mockFavoritesStore.getFavorites(isFavoritedQueryMaker)
    
        XCTAssertEqual(mockFavoritesStore.isFavoritedQueryFieldName, fieldName)
        XCTAssertEqual(mockFavoritesStore.isFavoritedQueryCollectionPath, collectionPath.rawValue)
        XCTAssertEqual(mockFavoritesStore.isFavoritedQueryFilterValue, fieldQueryValue)
    }
    
    func testUnfavoriteChangeFavoriteMethod() async throws {
        
        let collectionPath = FavoritesStoreCollection.isFavorited
        let birdName = "Sparrow"
        let isFavorited = false
        let data: [String : Any] = [
            "name": birdName,
            "isFavorited": isFavorited
        ]
        
        let unfavoriteDocumentMaker = IsFavoritedDocumentMaker(collectionPath: collectionPath,
                                                                  birdName: birdName,
                                                                  isFavorited: isFavorited)
        
        try await mockFavoritesStore.changeFavorite(unfavoriteDocumentMaker)
        
        XCTAssertEqual(mockFavoritesStore.changeFavoriteCollectionPath, collectionPath.rawValue)
        XCTAssertEqual(mockFavoritesStore.changeFavoriteBirdName, birdName)
        XCTAssertEqual(mockFavoritesStore.changeFavoriteDocumentData as NSDictionary, data as NSDictionary)
        XCTAssertEqual(mockFavoritesStore.changeFavoriteIsFavorited, isFavorited)
    }
}
