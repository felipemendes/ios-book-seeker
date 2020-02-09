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
        presentSearch()
    }

    // MARK: - PRIVATE FUNCTIONS

    // MARK: Search

    private func presentSearch() {
        let viewController = factory.makeBookSeekerSearchTextFieldViewController()
        viewController.delegate = self
        navigationController.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController.pushViewController(viewController, animated: true)
    }

    // MARK: SearchResult

    private func presentSearchResult(withTerm term: String) {
        let viewController = factory.makeSearchResultViewController(withTerm: term)
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }

    // MARK: SearchDetails

    private func presentDetails(withIdentifier identifier: Int) {
        let viewController = factory.makeBookSeekerDetailViewController(withIdentifier: identifier)
        viewController.delegate = self
        let detailNavigation = UINavigationController(rootViewController: viewController)
        navigationController.present(detailNavigation, animated: true, completion: nil)
    }
}

// MARK: - BookSeekerSearchTextFieldViewControllerDelegate

extension FlowController: BookSeekerSearchTextFieldViewControllerDelegate {
    public func bookSeekerSearchTextFieldViewControllerDelegate(_ viewController: UIViewController,
                                                                didSearch keyword: String) {
        presentSearchResult(withTerm: keyword)
    }
}

// MARK: - BookSeekerSearchResultDelegate

extension FlowController: BookSeekerSearchResultDelegate {
    public func bookSeekerSearchResultDelegate(_ viewController: UIViewController, didTap bookId: Int) {
        presentDetails(withIdentifier: bookId)
    }
}

// MARK: - BookSeekerDetailViewControllerDelegate

extension FlowController: BookSeekerDetailViewControllerDelegate {
    public func bookSeekerDetailViewControllerDelegate(_ viewController: UIViewController, didTapLink url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
}
