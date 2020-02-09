//
//  AlertType.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 08/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import Foundation

enum AlertType {
    case loading
    case message(_ message: String)
    case dismiss
}
