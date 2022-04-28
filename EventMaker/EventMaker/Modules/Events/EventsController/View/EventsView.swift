//
//  EventsView.swift
//  EventMaker
//
//  Created by Олег Романов on 22.04.2022.
//

import UIKit

final class EventsView: UIView {
    struct Appearance {
        static let tableHeight = 404
    }

    // MARK: - Properties

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.tableFooterView = UIView()
        return tableView
    }()

    lazy var addPersonButton = UIBarButtonItem(
        barButtonSystemItem: .add, target: nil, action: nil
    )

    var dataSource: EventsDataSource?

    // MARK: - Init

    init() {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
        tableView.dataSource = dataSource
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        setupStyle()
        addSubviews()
        makeConstraints()
    }

    func initDataSource() {
        dataSource = EventsDataSource(tableView: tableView)
    }

    private func setupStyle() {
        backgroundColor = Assets.background1.color
    }

    private func addSubviews() {
        addSubview(tableView)
    }

    private func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - Internal Methods

    func addEvent(_ event: Event) {
        dataSource?.addEvent(event)
    }

    func updateData(_ data: [Event]) {
        dataSource?.updateData(data)
    }
}
