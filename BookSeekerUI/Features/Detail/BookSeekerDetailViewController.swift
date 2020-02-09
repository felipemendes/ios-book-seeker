//
//  BookSeekerDetailViewController.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 09/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import UIKit
import RxSwift
import JGProgressHUD
import Kingfisher

public class BookSeekerDetailViewController: UIViewController, ViewLayoutable, HasCustomView {

    // MARK: - CONSTANTS

    private struct Constants {
        static let noDataFound: String = "No data found"
    }

    // MARK: - PROPERTIES

    private let disposeBag = DisposeBag()
    private let viewModel: BookSeekerDetailViewModel
    private var identifier: Int
    private var book: Book?

    // MARK: - PUBLIC API

    weak var delegate: BookSeekerDetailViewControllerDelegate?
    var alertView: JGProgressHUD = JGProgressHUD(style: .light)
    public typealias CustomView = DetailsItemView

    // MARK: - INITIALIZERS

    public init(identifier: Int,
                viewModel: BookSeekerDetailViewModel) {
        self.viewModel = viewModel
        self.identifier = identifier
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
        viewModel.retrieveBook(for: identifier)
    }

    public override func loadView() {
        let customView = CustomView()
        view = customView
        configureNavigationBar()
    }

    // MARK: - BINDING

    private func bindObservables() {
        viewModel.bookResponseObservable
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { response in
                self.performBindind(for: response)
            }).disposed(by: disposeBag)
    }

    // MARK: - PRIVATE SETUP

    private func layoutView() {
        view.backgroundColor = .white
    }

    // MARK: - PRIVATE FUNCTIONS

    private func performBindind(for response: BookResponseType) {
        if let error = response.error {
            updateAlert(to: .message(error))
            return
        }

        guard let book = response.bookResponse?.results.first else {
            updateAlert(to: .message(Constants.noDataFound))
            return
        }

        self.book = book
        navigationItem.title = book.name
        customView.setup(withBook: book)
        updateAlert(to: .dismiss)
    }

    private func configureNavigationBar() {
        let linkItem = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(openExternalUrl))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(close))

        navigationItem.leftBarButtonItem = linkItem
        navigationItem.rightBarButtonItem = cancelItem
    }

    // MARK: - HANDLERS

    @objc func openExternalUrl() {
        guard let url = book?.artistUrl else { return }
        delegate?.bookSeekerDetailViewControllerDelegate(self, didTapLink: url)
    }

    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
}
