//
//  DetailedEventController.swift
//  EventMaker
//
//  Created by Олег Романов on 24.04.2022.
//

import Foundation

import UIKit

class DetailedEventController: UIViewController {
    let viewModel: EventViewModel
    let event: Event
    var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.tableFooterView = UIView()
        return tableView
    }()

    override func loadView() {
        view = tableView
    }

    init(event: Event) {
        self.event = event
        self.viewModel = EventViewModel(event: event)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = viewModel
        tableView.delegate = viewModel

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension

        tableView.register(EventParticipantsCell.nib, forCellReuseIdentifier: "ParticipantCell")
        tableView.register(EventDateCell.nib, forCellReuseIdentifier: "DateCell")
        tableView.register(EventDescriptionCell.nib, forCellReuseIdentifier: "DescriptionCell")

        setupNavItem()
    }

    private func setupNavItem() {
        let shareButton = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(share))
        navigationItem.rightBarButtonItem = shareButton
    }

    @objc
    private func share() {
        let text = "toast://event?id=\(event.id)"
        let activityController = UIActivityViewController(
            activityItems: [text], applicationActivities: nil
        )
        activityController.popoverPresentationController?.sourceView = view
        present(activityController, animated: true, completion: nil)
    }
}
