//
//  BookSeekerUITests.swift
//  BookSeekerUITests
//
//  Created by Felipe Mendes on 09/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import XCTest
@testable import BookSeeker

class BookSeekerUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitests")
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_view_elements_existence() throws {
        // Give
        let search = "Swift"

        // When
        let searchTextField = app.textFields["Search TextField"]
        searchTextField.tap()
        app.typeText(search)

        app.buttons["Done"].tap()

        // Then
        XCTAssertTrue(searchTextField.exists)
    }
}
