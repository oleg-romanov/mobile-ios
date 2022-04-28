//
//  EventTypeController.swift
//  EventMaker
//
//  Created by Олег Романов on 28.04.2022.
//

import UIKit

protocol EventTypeDelegate: AnyObject {
    func sendEventTypeId(categoryId: Int)
}

class EventTypeDataSource: NSObject {
    var data: [EventType] = []

    var oneCellChosen: Bool = false

    var closure: ((Int, String) -> Void)?

    var addEventTypeClosure: (() -> Void)?

    var selectedCellForIndexPath: IndexPath?

    var tableView: UITableView

    init(tableView: UITableView) {
        self.tableView = tableView
        self.tableView.register(UINib(nibName: "EventTypeCell", bundle: .main), forCellReuseIdentifier: "Cell")
//
        super.init()
        tableView.dataSource = self
        tableView.delegate = self
    }

    func updateData(_ data: [EventType]) {
        self.data = data
        tableView.reloadData()
    }
}

extension EventTypeDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? EventTypeCell else {
            fatalError("Can't dequeue cell")
        }
        if indexPath.row < data.count {
            let eventType = data[indexPath.row]
            cell.configure(eventType: eventType)
        } else {
            cell.addEventTypeConfigure()
        }
        return cell
    }
}

extension EventTypeDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if let selectedIndexPath = selectedCellForIndexPath {
            tableView.cellForRow(at: selectedIndexPath)?.accessoryType = .none
        }
        if indexPath.row != tableView.numberOfRows(inSection: 0) - 1 {
            selectedCellForIndexPath = indexPath
            cell?.accessoryType = .checkmark
        } else {
            addEventTypeClosure?()
            return
        }
        closure?(data[indexPath.row].id, data[indexPath.row].name)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
