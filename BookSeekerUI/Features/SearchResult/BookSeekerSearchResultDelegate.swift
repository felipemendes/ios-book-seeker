//
//  BookSeekerSearchResultDelegate.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 08/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import UIKit

public protocol BookSeekerSearchResultDelegate: AnyObject {
    func bookSeekerSearchResultDelegate(_ viewController: UIViewController, didTap bookId: Int)
}
