//
//  FlowController.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 09/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import UIKit

public final class FlowController {

    // MARK: - PRIVATE PROPERTIES

    private let factory: Factory

    // MARK: - INITIALIZER

    public init(navigationController: UINavigationController,
                factory: Factory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    // MARK: - PUBLIC API

    /// This navigation controller holds all internal UIViewControllers
    /// that will be stack over app execution.
    public let navigationController: UINavigationController

    /// Starts the main flow. This will setup the internal Main Controller and
    /// push it into navigation controller.
    public func start() {
        presentSearchResult(withTerm: "Direito")
    }

    private func presentSearchResult(withTerm term: String) {
        let viewController = factory.makeSearchResultViewController(withTerm: term)
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - BookSeekerSearchResultDelegate

extension FlowController: BookSeekerSearchResultDelegate {
    public func bookSeekerSearchResultDelegate(_ viewController: UIViewController, didTap bookId: Int) {
        print(#function)
    }
}
