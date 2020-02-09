//
//  BaseTableViewController.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 08/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import UIKit

public class BaseTableViewController<T: BaseTableViewCell<U>, U>: UITableViewController {

    // MARK: - PROPERTIES

    private let cellId = "cellId"

    // MARK: - PUBLIC API

    var items = [U]()

    // MARK: - LIFE CYCLE

    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(T.self, forCellReuseIdentifier: cellId)
    }

    // MARK: - TABLEVIEW SETUP

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
            as? BaseTableViewCell<U> else {
                return UITableViewCell()
        }
        cell.item = items[indexPath.row]
        return cell
    }
}
