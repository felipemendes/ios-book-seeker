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

public struct ServiceManager: Service {

    // MARK: - TYPEALIASES

    typealias BookCompletion = (_ book: BookResponse?, _ error: String?) -> Void

    // MARK: - PROPERTIES

    let provider = MoyaProvider<BookRequest>(plugins: [NetworkLoggerPlugin(verbose: true)])

    // MARK: - PUBLIC APIs

    /// Get a book by term
    ///
    /// - Throws: Throws a Book and a possible error message
    func getBook(withTerm term: String, completion: @escaping BookCompletion) {

        provider.request(.getBook(term: term)) { response in
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
