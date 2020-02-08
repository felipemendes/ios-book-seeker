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
    case getBook(term: String)
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
        case .getBook(let term):
            return "search?term=\(term)&entity=ibook"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getBook:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
