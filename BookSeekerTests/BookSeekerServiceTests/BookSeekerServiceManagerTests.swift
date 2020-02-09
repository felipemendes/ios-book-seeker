//
//  BookSeekerServiceTests.swift
//  BookSeekerTests
//
//  Created by Felipe Mendes on 08/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import XCTest
import Foundation
import CoreData
import RxBlocking

@testable import BookSeeker

class BookSeekerServiceManagerTests: XCTestCase {

    private var sut: ServiceManager!

    override func setUp() {
        super.setUp()
        sut = ServiceManager()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    /// Ensures that API is retrieving a valid book response from a search keyword
    func test_api_retrieve_a_valid_book_response() throws {
        // Given
        let expectation = XCTestExpectation(description: "Retrieve a valid book from API")
        var bookResponse: BookResponse?
        var errorResponse: String?
        let search = "Swift"

        // When
        sut.getBooks(withTerm: search) { response, error in
            if let error = error {
                XCTFail("Error: \(error)")
                return
            }
            bookResponse = response
            errorResponse = error
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertNotNil(bookResponse)
        XCTAssertNil(errorResponse)
    }

    /// Ensures that API is retrieving a valid book response from a search by its identifier
    func test_api_retrieve_a_valid_book_response_by_identifier() throws {
        // Given
        let expectation = XCTestExpectation(description: "Retrieve a valid unique book from API")
        var bookResponse: BookResponse?
        var errorResponse: String?
        let identifier = 881256329

        // When
        sut.getBook(byId: identifier) { response, error in
            if let error = error {
                XCTFail("Error: \(error)")
                return
            }
            bookResponse = response
            errorResponse = error
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertNotNil(bookResponse)
        XCTAssertNil(errorResponse)
    }

    /// Ensures that mocked API is retrieving a valid book response from a search keyword
    func test_mock_api_retrieve_a_valid_book_response() throws {
        // Given
        let expectation = XCTestExpectation(description: "Retrieve a valid book from mock API")
        var bookResponse: BookResponse?
        var errorResponse: String?
        let search = "Swift"

        // When
        sut.getMockBooks(withTerm: search) { response, error in
            if let error = error {
                XCTFail("Error: \(error)")
                return
            }
            bookResponse = response
            errorResponse = error
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertNotNil(bookResponse)
        XCTAssertNil(errorResponse)
    }
}
