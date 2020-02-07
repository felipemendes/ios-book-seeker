//
//  SearchDataAccessProvider.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 06/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

public class SearchDataAccessProvider {

    // MARK: - CONSTANTS

    private let entityName = "Search"

    // MARK: - PRIVATE PROPERTIES

    private var searchFromCoreData = Variable<[Search]>([])
    private var managedObjectContext: NSManagedObjectContext

    // MARK: - INITIALIZER

    init() {
        // swiftlint:disable force_cast
        let delegate = UIApplication.shared.delegate as! AppDelegate
        searchFromCoreData.value = [Search]()
        managedObjectContext = delegate.persistentContainer.viewContext
        searchFromCoreData.value = retrieveData()
    }

    // MARK: - PRIVATE SETUP

    public func retrieveObservableData() -> Observable<[Search]> {
        searchFromCoreData.value = retrieveData()
        return searchFromCoreData.asObservable()
    }

    public func add(_ keyword: String) {
        if checkExistence(for: keyword) {
            print("Data already added")
            return
        }

        let newSearch = NSEntityDescription.insertNewObject(forEntityName: entityName,
                                                            into: managedObjectContext) as! Search
        newSearch.keyword = keyword

        do {
            try managedObjectContext.save()
            searchFromCoreData.value = retrieveData()
        } catch {
            fatalError("Error on add data: \(#function) on \(#line)")
        }
    }

    public func deleteAll() {
        searchFromCoreData.value.forEach {
            managedObjectContext.delete($0)
        }

        do {
            try managedObjectContext.save()
            searchFromCoreData.value = retrieveData()
        } catch {
            fatalError("Error on delete data")
        }
    }

    // MARK: - PRIVATE SETUP

    private func checkExistence(for keyword: String) -> Bool {
        let currentData = retrieveData()
        return currentData.filter({ $0.keyword == keyword}).count > 0
    }

    private func retrieveData() -> [Search] {
        let searchRequest = Search.searchRequest()
        searchRequest.returnsObjectsAsFaults = false

        do {
            return try managedObjectContext.fetch(searchRequest)
        } catch {
            print("No Search Data retrieved")
            return []
        }
    }
}
