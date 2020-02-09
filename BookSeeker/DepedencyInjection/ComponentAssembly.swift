//
//  ComponentAssembly.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 09/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import Swinject

public class ComponentAssembly: Assembly {

    public func assemble(container: Container) {

        // MARK: - PastSearchesView

        container.register(PastSearchesView.self) { resolver in
            let viewModel = resolver.resolve(PastSearchesViewModel.self)!
            return PastSearchesView(viewModel: viewModel)
        }

        container.register(PastSearchesViewModel.self) { resolver in
            let searchDataAccessProvider = resolver.resolve(SearchDataAccessProvider.self)!
            return PastSearchesViewModel(searchDataAccessProvider: searchDataAccessProvider)
        }
    }
}
