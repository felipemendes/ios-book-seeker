//
//  FeatureAssembly.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 09/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import Swinject

public class FeatureAssembly: Assembly {

    public func assemble(container: Container) {
        container.register(FlowController.self) { (resolver: Resolver, navigationController: UINavigationController) in
            let factory = resolver.resolve(Factory.self)!
            return FlowController(navigationController: navigationController,
                                  factory: factory)
        }

        // MARK: - Factory

        container.register(Factory.self) { resolver in
            return FactoryImplementation(resolver: resolver)
        }

        // MARK: - BookSeekerSearchResultViewController

        container.register(BookSeekerSearchResultViewModel.self) { resolver in
            let serviceManager = resolver.resolve(ServiceManager.self)!
            return BookSeekerSearchResultViewModel(serviceManager: serviceManager)
        }

        container.register(BookSeekerSearchResultViewController.self) { (resolver, term: String) in
            let viewModel = resolver.resolve(BookSeekerSearchResultViewModel.self)!
            return BookSeekerSearchResultViewController(withTerm: term,
                                                        viewModel: viewModel)
        }
    }
}
