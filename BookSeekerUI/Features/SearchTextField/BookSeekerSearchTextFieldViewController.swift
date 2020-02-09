//
//  BookSeekerSearchTextFieldViewController.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 09/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import UIKit

public class BookSeekerSearchTextFieldViewController: UIViewController, HasCustomView {

    // MARK: - CONSTANTS

    private struct Constants {
        static let keywordMinLengthForSearch: Int = 3
    }

    // MARK: - PROPERTIES

    private let viewModel: BookSeekerSearchTextFieldViewModel
    private let pastSearchesViewModel: PastSearchesViewModel

    // MARK: - PUBLIC API

    weak var delegate: BookSeekerSearchTextFieldViewControllerDelegate?
    public typealias CustomView = SearchTextFieldItemView

    // MARK: - INITIALIZERS

    public init(viewModel: BookSeekerSearchTextFieldViewModel,
                pastSearchesViewModel: PastSearchesViewModel) {
        self.viewModel = viewModel
        self.pastSearchesViewModel = pastSearchesViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LIFE CYCLE

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        layoutView()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customView.reloadComponents()
        customView.delegate = self
    }

    public override func loadView() {
        let customView = CustomView(pastSearchesViewModel: pastSearchesViewModel)
        view = customView
    }

    // MARK: - PRIVATE SETUP

    private func layoutView() {
        view.backgroundColor = .white
    }

    private func perform(search keyword: String, from: SearchType) {
        switch from {
        case .pastSearch: ()
        case .textInput:
            if viewModel.check(minLength: Constants.keywordMinLengthForSearch, for: keyword) {
                return
            }
            viewModel.addSearch(keyword: keyword)
            customView.resetView()
        }
        delegate?.bookSeekerSearchTextFieldViewControllerDelegate(self, didSearch: keyword)
    }
}

// MARK: - SearchTextFieldItemViewDelegate

extension BookSeekerSearchTextFieldViewController: SearchTextFieldItemViewDelegate {
    public func searchTextFieldItemView(_ searchTextFieldItemView: SearchTextFieldItemView,
                                        didSearch keyword: String,
                                        withSearchType searchType: SearchType) {
        perform(search: keyword, from: searchType)
    }
}
