//
//  BookSeekerDetailViewControllerDelegate.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 09/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import UIKit

public protocol BookSeekerDetailViewControllerDelegate: AnyObject {
    func bookSeekerDetailViewControllerDelegate(_ viewController: UIViewController, didTapLink url: String)
}
