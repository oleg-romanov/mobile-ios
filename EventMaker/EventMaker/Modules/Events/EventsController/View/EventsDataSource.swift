//
//  EventsDataSource.swift
//  EventMaker
//
//  Created by Олег Романов on 23.04.2022.
//

import UIKit

final class EventsDataSource: NSObject {
    // MARK: - Properties

    private var data: [[Event]] = []
    private var tableView: UITableView?
    var detailedEventClosure: ((Event) -> Void)?
    var deleteEventClosure: ((Int) -> Void)?

    init(tableView: UITableView) {
        self.tableView = tableView
        tableView.register(EventCell.self, forCellReuseIdentifier: "TableCell")
        super.init()
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - Internal methods

    func updateData(_ data: [Event]) {
        self.data = []
        let groupped = Dictionary(grouping: data, by: { event in
            Calendar.current.component(.month, from: event.date)
        })
        groupped.keys.forEach { [weak self] key in
            guard let array = groupped[key] else { return }
            self?.data.append(array)
        }
        sortData()
        print("\(data.count)")
        tableView?.reloadData()
    }

    func addEvent(_ event: Event) {
        for index in data.indices {
            guard let currentPersonBirthdate = data[index].first?.date
            else { continue }
            let personMonth: Int = Calendar.current.component(.month, from: event.date)
            let currentPersonMonth: Int = Calendar.current.component(.month, from: currentPersonBirthdate)
            if personMonth == currentPersonMonth {
                data[index].append(event)
                sortData()
                tableView?.reloadSections(IndexSet(index ... index), with: .automatic)
                return
            }
        }
        data.append([event])
        sortData()
        tableView?.reloadData()
    }

    private func sortData() {
        data = data.sorted { array1, array2 in
            guard let date1 = array1.first?.date, let date2 = array2.first?.date else { return false }
            let day1 = Calendar.current.component(.month, from: date1)
            let day2 = Calendar.current.component(.month, from: date2)
            return day1 < day2
        }
        for index in data.indices {
            data[index] = data[index].sorted { p1, p2 in
                let day1 = Calendar.current.component(.day, from: p1.date)
                let day2 = Calendar.current.component(.day, from: p2.date)
                return day1 < day2
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension EventsDataSource: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return data.count
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "TableCell",
            for: indexPath
        ) as? EventCell
        let item = data[indexPath.section][indexPath.row]
        cell?.configure(cell: item)
        return cell ?? UITableViewCell()
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 40
    }

    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let date = data[section].first?.date else { return nil }
        let view = DateSectionHeader()
        view.configure(date: date)
        return view
    }
}

// MARK: - UITableViewDelegate

extension EventsDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailedEventClosure?(data[indexPath.section][indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }

//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, indexPath in
//            self.deleteEventClosure?(self.data[indexPath.section][indexPath.row].id)
//            self.data[indexPath.section].remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//            tableView.reloadData()
//        }
//        return [deleteAction]
//    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        deleteEventClosure?(data[indexPath.section][indexPath.row].id)
        data[indexPath.section].remove(at: indexPath.row)
        tableView.reloadData()
    }
}
