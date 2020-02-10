//
//  ServiceManager.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 06/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import Foundation
import Moya

// swiftlint:disable type_name
protocol Service {
    associatedtype T: TargetType
    var provider: MoyaProvider<T> { get }
}

// MARK: - TYPEALIASES

typealias BookCompletion = (_ book: BookResponse?, _ error: String?) -> Void

public struct ServiceManager: Service {

    // MARK: - PROPERTIES

    let provider = MoyaProvider<BookRequest>(plugins: [NetworkLoggerPlugin(verbose: true)])

    // MARK: - PUBLIC APIs

    /// Get a search books by term
    ///
    /// - Throws: Throws a Book and a possible error message
    func getBooks(withTerm term: String, completion: @escaping BookCompletion) {

        provider.request(.getBooks(term: term)) { response in
            switch response {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(BookResponse.self, from: response.data)
                    completion(results, nil)
                } catch let error {
                    completion(nil, "[API Error]: \(error.localizedDescription)")
                    return
                }
            case let .failure(error):
                completion(nil, "[API Error]: \(error.localizedDescription)")
                return
            }
        }
    }

    /// Get a book by its identifier
    ///
    /// - Throws: Throws a Book and a possible error message
    func getBook(byId bookId: Int, completion: @escaping BookCompletion) {

        provider.request(.getBook(bookId: bookId)) { response in
            switch response {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(BookResponse.self, from: response.data)
                    completion(results, nil)
                } catch let error {
                    completion(nil, "[API Error]: \(error.localizedDescription)")
                    return
                }
            case let .failure(error):
                completion(nil, "[API Error]: \(error.localizedDescription)")
                return
            }
        }
    }
}
