//
//  BirdDetailViewUITests.swift
//  Special ParakeetUITests
//
//  Created by Asaad Jaber on 29/12/2023.
//

import XCTest

final class BirdDetailViewUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        
        app.launch()
        
        continueAfterFailure = false
    }

    func testButtonNavigation() {
        
        let birdName = "Accipiter"
        
        let button = app.descendants(matching: .any)
            .children(matching: .button)
            .matching(.button, identifier: birdName)
            .firstMatch
        
        XCTAssertTrue(button.exists)

        button.tap()
        
        let label = app.descendants(matching: .any)
            .children(matching: .any)
            .element(matching: .any, identifier: "birdDetailViewBirdNameText")
            .firstMatch
        
        XCTAssertTrue(label.exists)
        
        XCTAssertEqual(label.label, birdName)
    }
}
