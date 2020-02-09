//
//  DetailsItemView.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 09/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import UIKit
import Kingfisher

final public class DetailsItemView: UIView {

    // MARK: - METRICS

    private struct Metrics {
        static let titleTop: CGFloat = 28
        static let titleLeading: CGFloat = 12
        static let titleTrailing: CGFloat = -12

        static let desciptionTop: CGFloat = 12
        static let desciptionLeading: CGFloat = 12
        static let desciptionTrailing: CGFloat = -12

        static let imageTop: CGFloat = 12
        static let imageHeight: CGFloat = 100
        static let imageBottom: CGFloat = -12
    }

    // MARK: - CONSTANTS

    private struct Constants {
        static let titleFontSize: CGFloat = 16
        static let descriptionFontSize: CGFloat = 12
        static let publisherDescription: String = "Publisher Description"
    }

    // MARK: - PROPERTIES

    private var book: Book?

    // MARK: - INITIALIZERS

    init() {
        super.init(frame: .zero)
        layoutView()
        setupUI()
        constraintUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        return scrollView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        label.text = Constants.publisherDescription
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        label.numberOfLines = 0
        return label
    }()

    private lazy var coverImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = false
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - PUBLIC API

    func setup(withBook book: Book) {
        let cover = URL(string: book.cover)
        coverImage.kf.setImage(with: cover)

        descriptionLabel.attributedText = book.description.htmlToAttributedString
    }

    // MARK: - PRIVATE SETUP

    private func layoutView() {
        backgroundColor = .white
    }

    private func setupUI() {
        addSubview(scrollView)
        scrollView.addSubview(coverImage)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(descriptionLabel)
    }

    private func constraintUI() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            titleLabel.safeTopAnchor.constraint(equalTo: scrollView.topAnchor, constant: Metrics.titleTop),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.titleLeading),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Metrics.titleTrailing),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.desciptionTop),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.desciptionLeading),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Metrics.desciptionTrailing),

            coverImage.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Metrics.imageTop),
            coverImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            coverImage.heightAnchor.constraint(equalToConstant: Metrics.imageHeight),
            coverImage.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: Metrics.imageBottom)
        ])
    }
}
