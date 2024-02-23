//
//  IsFavoritedUnitTests.swift
//  Special ParakeetTests
//
//  Created by Asaad Jaber on 16/02/2024.
//

import XCTest
import SwiftUI
import FirebaseFirestore
@testable import Special_Parakeet

final class IsFavoritedUnitTests: XCTestCase {

    var mockIsFavorited: MockIsFavorited!
    
    override func setUpWithError() throws {
        self.mockIsFavorited = MockIsFavorited(name: "Sparrow", 
                                               family: "",
                                               isFavorited: false,
                                               favoritesStore: MockFavoritesStore())
    }
    
    @MainActor
    func testToggleFavoriteButtonCallsChangeFavorite() async {
        let isFavorited = true
                            
         mockIsFavorited.isFavorited = isFavorited
                            
        XCTAssertEqual(mockIsFavorited.didCallMakeFavorite, true)
    }
}
