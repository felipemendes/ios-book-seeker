//
//  ViewLayoutable.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 08/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import UIKit
import JGProgressHUD

protocol ViewLayoutable: class {
    var alertView: JGProgressHUD { get }

    func updateAlert(to type: AlertType)
}

// MARK: - EXTENSIONS

extension ViewLayoutable where Self: UIViewController {

    // MARK: - DEFAULT IMPLEMENTATIONS

    func updateAlert(to type: AlertType) {
        alertView.show(in: view, animated: true)

        switch type {
        case .loading:
            alertView.textLabel.text = "Loading ..."
        case .message(let message):
            alertView.textLabel.text = "Error: \(message)"
        case .dismiss:
            alertView.dismiss(animated: true)
        }
    }
}
