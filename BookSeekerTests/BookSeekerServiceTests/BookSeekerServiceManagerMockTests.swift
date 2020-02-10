//
//  BookSeekerServiceManagerMockTests.swift
//  BookSeekerTests
//
//  Created by Felipe Ribeiro Mendes on 10/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import XCTest
import Foundation
import CoreData
import RxBlocking

@testable import BookSeeker

class BookSeekerServiceManagerMockTests: XCTestCase {

    private var sut: ServiceManager!

    override func setUp() {
        super.setUp()
        sut = ServiceManagerMock()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
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
