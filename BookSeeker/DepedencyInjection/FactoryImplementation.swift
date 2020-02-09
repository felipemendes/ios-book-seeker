//
//  FactoryImplementation.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 09/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import Swinject

public class FactoryImplementation: Factory {

    // MARK: - PRIVATE PROPERTIES

    private let resolver: Resolver

    // MARK: - PUBLIC API

    public init(resolver: Resolver) {
        self.resolver = resolver
    }

    // MARK: - FACTORY

    public func makeSearchResultViewController(withTerm term: String) -> BookSeekerSearchResultViewController {
        return resolver.resolve(BookSeekerSearchResultViewController.self, argument: term)!
    }

    public func makeBookSeekerDetailViewController(withIdentifier identifier: Int) -> BookSeekerDetailViewController {
        return resolver.resolve(BookSeekerDetailViewController.self, argument: identifier)!
    }

    public func makeBookSeekerSearchTextFieldViewController() -> BookSeekerSearchTextFieldViewController {
        return resolver.resolve(BookSeekerSearchTextFieldViewController.self)!
    }
}
