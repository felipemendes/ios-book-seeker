//
//  BookSeekerDetailViewModel.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 09/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import RxSwift
import Foundation

public class BookSeekerDetailViewModel {

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

    func retrieveBook(for identifier: Int) {
        serviceManager.getBook(byId: identifier) { response, error in
            self.handleBookResponse(response, error)
        }
    }

    // MARK: - PRIVATE FUNCTIONS

    private func handleBookResponse(_ bookResponse: BookResponse?, _ error: String?) {
        bookResponseObservable.onNext((bookResponse, error))
    }
}
