//
//  ServiceManagerMock.swift
//  BookSeeker
//
//  Created by Felipe Ribeiro Mendes on 10/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import Foundation
import Moya

public struct ServiceManagerMock: Service {

    // MARK: - PROPERTIES

    let provider = MoyaProvider<BookRequest>(stubClosure: MoyaProvider.immediatelyStub)

    // MARK: - PUBLIC APIs

    /// Get a mocked search books by term
    ///
    /// - Throws: Throws a mocked Book and a possible error message
    func getBooks(withTerm term: String, completion: @escaping BookCompletion) {

        provider.request(.getBooks(term: term)) { response in
            switch response {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(BookResponse.self, from: response.data)
                    completion(results, nil)
                } catch let error {
                    completion(nil, "[Mock Error]: \(error.localizedDescription)")
                    return
                }
            case let .failure(error):
                completion(nil, "[Mock Error]: \(error.localizedDescription)")
                return
            }
        }
    }
}
