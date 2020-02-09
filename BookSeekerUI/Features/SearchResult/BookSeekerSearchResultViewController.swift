//
//  BookSeekerSearchResultViewController.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 08/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import UIKit
import RxSwift
import JGProgressHUD

public class BookSeekerSearchResultViewController: BaseTableViewController<BookCell, Book>, ViewLayoutable {

    // MARK: - CONSTANTS

    private struct Constants {
        static let title: String = "In Your Library"
        static let noDataFound: String = "No data found"
    }

    // MARK: - PROPERTIES

    private let disposeBag = DisposeBag()
    private let term: String
    private let viewModel: BookSeekerSearchResultViewModel
    private var bookResponse: BookResponse?

    // MARK: - PUBLIC API

    weak var delegate: BookSeekerSearchResultDelegate?
    var alertView: JGProgressHUD = JGProgressHUD(style: .light)

    // MARK: - INITIALIZERS

    public init(withTerm term: String,
                viewModel: BookSeekerSearchResultViewModel) {
        self.term = term
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        layoutView()
        bindObservables()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LIFE CYCLE

    override public func viewDidLoad() {
        super.viewDidLoad()
        updateAlert(to: .loading)
        viewModel.retrieveSearchBook(from: term)
    }

    // MARK: - BINDING

    private func bindObservables() {
        viewModel.bookResponseObservable
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { response in
                self.performBindind(for: response)
            }).disposed(by: disposeBag)
    }

    // MARK: - PRIVATE FUNCTIONS

    private func layoutView() {
        navigationItem.title = Constants.title
        view.backgroundColor = .white
    }

    private func performBindind(for response: BookResponseType) {
        if let error = response.error {
            updateAlert(to: .message(error))
            return
        }

        if response.bookResponse?.results.count == 0 {
            updateAlert(to: .message(Constants.noDataFound))
            return
        }

        bookResponse = response.bookResponse
        guard let results = response.bookResponse?.results else { return }
        items = results
        tableView.reloadData()
        updateAlert(to: .dismiss)
    }

    // MARK: - TABLEVIEW SETUP

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookId = items[indexPath.row].bookId
        delegate?.bookSeekerSearchResultDelegate(self, didTap: bookId)
    }
}
