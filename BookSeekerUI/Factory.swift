//
//  Factory.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 09/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import Foundation

public protocol Factory {

    /// Builds a BookSeekerSearchResultViewController
    ///
    /// - Returns: An instantiated BookSeekerSearchResultViewController
    func makeSearchResultViewController(withTerm term: String) -> BookSeekerSearchResultViewController
}
