//
//  Search.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 06/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import Foundation
import CoreData

@objc(Search)
public class Search: NSManagedObject {

    @nonobjc public class func searchRequest() -> NSFetchRequest<Search> {
        return NSFetchRequest<Search>(entityName: "Search")
    }

    @NSManaged public var keyword: String
}
