//
//  BookSeekerSearchResultViewModel.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 08/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import RxSwift
import Foundation

typealias BookResponseType = (bookResponse: BookResponse?, error: String?)

public class BookSeekerSearchResultViewModel {

    // MARK: - PRIVATE PROPERTIES

    private let disposeBag = DisposeBag()
    private let serviceManager: ServiceManager

    // MARK: - PUBLIC

    let bookResponseObservable = PublishSubject<BookResponseType>()

    // MARK: - INITIALIZERS

    public init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
    }

    // MARK: - PUBLIC API

    func retrieveSearchBook(from term: String) {
        serviceManager.getBooks(withTerm: term) { response, error in
            self.handleBookResponse(response, error)
        }
    }

    // MARK: - PRIVATE FUNCTIONS

    private func handleBookResponse(_ bookResponse: BookResponse?, _ error: String?) {
        bookResponseObservable.onNext((bookResponse, error))
    }
}
