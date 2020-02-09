//
//  SearchTextFieldItemView.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 09/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import UIKit

public protocol SearchTextFieldItemViewDelegate: AnyObject {
    func searchTextFieldItemView(_ searchTextFieldItemView: SearchTextFieldItemView,
                                 didSearch keyword: String,
                                 withSearchType searchType: SearchType)
}

final public class SearchTextFieldItemView: UIView {

    // MARK: - METRICS

    private struct Metrics {
        static let titleTop: CGFloat = 30
        static let titleLeading: CGFloat = 8
        static let titleTrailing: CGFloat = -8

        static let searchFieldTop: CGFloat = 8
        static let searchFieldHeight: CGFloat = 40

        static let pastSearchesLeading: CGFloat = 8
        static let pastSearchesTrailing: CGFloat = -8
        static let pastSearchesTop: CGFloat = 8
        static let pastSearchesBottom: CGFloat = -8
    }

    // MARK: - CONSTANTS

    private struct Constants {
        static let titleFontSize: CGFloat = 20
        static let titleText: String = "Search"
        static let searchPlaceholder: String = "Apple Books"
    }

    // MARK: - PROPERTIES

    private let pastSearchesViewModel: PastSearchesViewModel

    // MARK: - INITIALIZERS

    init(pastSearchesViewModel: PastSearchesViewModel) {
        self.pastSearchesViewModel = pastSearchesViewModel
        super.init(frame: .zero)
        layoutView()
        setupUI()
        constraintUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        label.text = Constants.titleText
        return label
    }()

    private lazy var searchTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = Constants.searchPlaceholder
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        return textField
    }()

    private lazy var pastSearchesView: PastSearchesView = {
        let pastSearchesView = PastSearchesView(viewModel: pastSearchesViewModel)
        pastSearchesView.translatesAutoresizingMaskIntoConstraints = false
        pastSearchesView.delegate = self
        return pastSearchesView
    }()

    // MARK: - PUBLIC API

    weak var delegate: SearchTextFieldItemViewDelegate?

    func resetView() {
        searchTextField.resignFirstResponder()
        searchTextField.text = nil
    }

    func reloadComponents() {
        pastSearchesView.reloadView()
    }

    // MARK: - PRIVATE SETUP

    private func layoutView() {
        backgroundColor = .white
    }

    private func setupUI() {
        addSubview(titleLabel)
        addSubview(searchTextField)
        addSubview(pastSearchesView)
    }

    private func constraintUI() {
        NSLayoutConstraint.activate([
            titleLabel.safeTopAnchor.constraint(equalTo: safeTopAnchor, constant: Metrics.titleTop),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.titleLeading),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Metrics.titleTrailing),

            searchTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.searchFieldTop),
            searchTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            searchTextField.heightAnchor.constraint(equalToConstant: Metrics.searchFieldHeight),

            pastSearchesView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor,
                                                  constant: Metrics.pastSearchesTop),
            pastSearchesView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.pastSearchesLeading),
            pastSearchesView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Metrics.pastSearchesTrailing),
            pastSearchesView.safeBottomAnchor.constraint(equalTo: safeBottomAnchor,
                                                         constant: Metrics.pastSearchesBottom)
        ])
    }
}

// MARK: - UITextFieldDelegate

extension SearchTextFieldItemView: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        delegate?.searchTextFieldItemView(self, didSearch: text, withSearchType: .textInput)
        return true
    }
}

// MARK: - PastSearchesViewDelegate

extension SearchTextFieldItemView: PastSearchesViewDelegate {
    func pastSearchesView(_ pastSearchesView: PastSearchesView, didTappedIn keyword: String) {
        delegate?.searchTextFieldItemView(self, didSearch: keyword, withSearchType: .pastSearch)
    }
}
