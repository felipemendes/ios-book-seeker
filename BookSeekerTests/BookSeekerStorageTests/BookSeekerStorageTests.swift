//
//  BookSeekerStorageTests.swift
//  BookSeekerTests
//
//  Created by Felipe Mendes on 07/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import XCTest
import Foundation
import CoreData
import RxBlocking

@testable import BookSeeker

class BookSeekerTests: XCTestCase {

    private var sut: SearchDataAccessProvider!

    override func setUp() {
        super.setUp()
        sut = SearchDataAccessProvider()
        sut.deleteAll()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    /// Ensures that recent searches are stored and retrieved properly
    func test_add_new_search_keyword() throws {
        // Given
        let search = "Swift"

        // When
        sut.add(search)

        let results = try sut.retrieveObservableData().toBlocking().first()

        // Then
        XCTAssertNotNil(results)
        XCTAssert(results?.count == 1)
        XCTAssert(results?.first?.keyword == search)
    }

    /// Ensures that searching for the same term repeatedly does not add a new entry to the database for the same search
    func test_recent_search_are_not_duplicated() throws {
        // Given
        let search1 = "Apple"
        let search2 = "Google"
        let search3 = "Apple"

        // When
        sut.add(search1)
        sut.add(search2)
        sut.add(search3)

        let results = try sut.retrieveObservableData().toBlocking().first()

        // Then
        XCTAssertNotNil(results)
        XCTAssert(results?.count == 2)
    }

    /// Ensures that the last keyword searched is the first one to be shown on listing
    func test_last_in_first_out() throws {
        // Given
        let firstKeyword = "Brazil"
        let lastKeyword = "Japan"

        // When
        sut.add(firstKeyword)
        sut.add(lastKeyword)

        let results = try sut.retrieveObservableData().toBlocking().first()

        // Then
        XCTAssertNotNil(results)
        XCTAssert(results?.first?.keyword == lastKeyword)
    }

    /// Ensures that all terms searches are removed from database
    func test_remove_all_data() throws {
        // Given
        let searches = [ "Swift", "Career", "Celebrity", "Development"]

        // When
        _ = searches.map { sut.add($0) }

        sut.deleteAll()

        let results = try sut.retrieveObservableData().toBlocking().first()

        // Then
        XCTAssertNotNil(results)
        XCTAssert(results?.count == 0)
    }
}
