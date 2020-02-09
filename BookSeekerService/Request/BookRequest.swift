//
//  BookRequest.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 06/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import Foundation
import Moya

// MARK: - ENUM

enum BookRequest {
    case getBooks(term: String)
    case getBook(bookId: Int)
}

extension BookRequest: TargetType {
    var baseURL: URL {

        guard let url = URL(string: "https://itunes.apple.com/") else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }

    var path: String {
        switch self {
        case .getBooks:
            return "search"
        case .getBook:
            return "lookup"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        switch self {
        case .getBooks,
             .getBook:
            guard let url = Bundle.main.url(forResource: "book-response", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        }
    }

    var task: Task {
        switch self {
        case .getBooks(let term):
            let params: [String: Any] = ["term": term,
                                         "entity": "ibook"]
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        case .getBook(let bookId):
            let params: [String: Any] = ["id": bookId]
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
