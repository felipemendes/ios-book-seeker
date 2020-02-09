//
//  BookSeekerSearchTextFieldViewControllerDelegate.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 09/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import UIKit

public protocol BookSeekerSearchTextFieldViewControllerDelegate: AnyObject {
    func bookSeekerSearchTextFieldViewControllerDelegate(_ viewController: UIViewController,
                                                         didSearch keyword: String)
}
