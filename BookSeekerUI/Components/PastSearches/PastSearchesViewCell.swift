//
//  PastSearchesViewCell.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 09/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import UIKit

class PastSearchesViewCell: UICollectionViewCell {

    // MARK: - CONSTANTS

    private struct Constants {
        static let titleFontSize: CGFloat = 14
    }

    // MARK: - PROPERTIES

    private var value: String?

    // MARK: - UI

    private lazy var valueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.titleFontSize)
        return label
    }()

    // MARK: - INITIALIZERS

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LIFE CYCLE

    override func layoutSubviews() {
        super.layoutSubviews()
        constraintUI()
    }

    // MARK: - PUBLIC API

    public func setupCell(with value: String) {
        self.value = value
        setupUI()
    }

    // MARK: - SETUP

    private func setupUI() {
        valueLabel.text = value
    }

    private func constraintUI() {
        addSubview(valueLabel)
        valueLabel.constraintToSuperview()
    }
}
