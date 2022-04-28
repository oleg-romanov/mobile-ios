//
//  EventTypeController.swift
//  EventMaker
//
//  Created by Олег Романов on 28.04.2022.
//

import SnapKit
import UIKit

// Чисто для теста
import SPAlert

class EventTypeView: UIView {
    // MARK: - Properties

    lazy var addEventTypeButton = UIBarButtonItem(
        barButtonSystemItem: .add, target: nil, action: nil
    )

    lazy var searchBarItem = UISearchBar()

    private var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.tableFooterView = UIView()
        return tableView
    }()

    var dataSource: EventTypeDataSource?

    lazy var delegate = EventTypeDataSource(tableView: tableView)

    // MARK: - Init

    init() {
        super.init(frame: UIScreen.main.bounds)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        addSubviews()
        makeConstraints()
    }

    private func addSubviews() {
        addSubview(tableView)
    }

    private func makeConstraints() {}

    // MARK: - Internal methods

    func initDataSource() {
        dataSource = EventTypeDataSource(tableView: tableView)
    }

    func updateData(_ eventTypes: [EventType]) {
        dataSource?.updateData(eventTypes)
    }
}
