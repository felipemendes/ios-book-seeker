//
//  PastSearchesViewModel.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 09/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

public class PastSearchesViewModel {

    // MARK: - PRIVATE PROPERTIES

    private var searchCoreData = Variable<[Search]>([])
    private var disposeBag = DisposeBag()
    private var searchDataAccessProvider: SearchDataAccessProvider

    // MARK: - INITIALIZERS

    public init(searchDataAccessProvider: SearchDataAccessProvider) {
        self.searchDataAccessProvider = searchDataAccessProvider
        fetchSearchAndUpdateObservables()
    }

    // MARK: - PUBLIC FUNCTIONS

    public func retrieveSearches() -> Variable<[Search]> {
        return searchCoreData
    }

    public func addSearch(keyword: String) {
        searchDataAccessProvider.add(keyword)
    }

    // MARK: - PRIVATE FUNCTIONS

    private func fetchSearchAndUpdateObservables() {
        searchDataAccessProvider.retrieveObservableData()
            .map { $0 }
            .subscribe(onNext: {
                self.searchCoreData.value = $0.reversed()
            })
            .disposed(by: disposeBag)
    }
}
