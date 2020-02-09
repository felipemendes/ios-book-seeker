//
//  BookCell.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 08/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import UIKit
import Kingfisher

public class BookCell: BaseTableViewCell<Book> {

    // MARK: - METRICS

    private struct Metrics {
        static let coverTop: CGFloat = 16
        static let coverLeading: CGFloat = 8
        static let coverBottom: CGFloat = -16
        static let coverHeight: CGFloat = 80

        static let titleLeading: CGFloat = 8
        static let titleTrailing: CGFloat = -8

        static let artistTop: CGFloat = 8
        static let artistBottom: CGFloat = -8
    }

    // MARK: - CONSTANTS

    private struct Constants {
        static let titleFontSize: CGFloat = 16
        static let artistFontSize: CGFloat = 12
    }

    // MARK: - PROPERTIES

    override var item: Book! {
        didSet {
            constraintUI()
            setup()
        }
    }

    // MARK: - UI

    private lazy var coverImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        return label
    }()

    private lazy var artistLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: Constants.artistFontSize)
        return label
    }()

    // MARK: - SETUP

    private func setup() {
        guard let item = item else { return }

        let cover = URL(string: item.cover)
        coverImage.kf.setImage(with: cover)

        titleLabel.text = item.name
        artistLabel.text = item.artist
    }

    private func constraintUI() {
        contentView.addSubview(coverImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(artistLabel)

        NSLayoutConstraint.activate([
            coverImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.coverTop),
            coverImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.coverLeading),
            coverImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Metrics.coverBottom),
            coverImage.heightAnchor.constraint(equalToConstant: Metrics.coverHeight),
            coverImage.widthAnchor.constraint(equalToConstant: Metrics.coverHeight),

            titleLabel.topAnchor.constraint(equalTo: coverImage.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: coverImage.trailingAnchor, constant: Metrics.titleLeading),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Metrics.titleTrailing),

            artistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.artistTop),
            artistLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            artistLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            artistLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
}
