//
//  ViewCustomizable.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 09/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import UIKit

public protocol HasCustomView {
    associatedtype CustomView: UIView
}

// MARK: - EXTENSIONS

extension HasCustomView where Self: UIViewController {

    // MARK: - DEFAULT IMPLEMENTATIONS

    public var customView: CustomView {
        guard let customView = view as? CustomView else {
            fatalError("Expected view to be of type \(CustomView.self) but got \(type(of: view)) instead")
        }
        return customView
    }
}
