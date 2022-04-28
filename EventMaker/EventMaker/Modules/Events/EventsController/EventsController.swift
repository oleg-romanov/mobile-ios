//
//  EventsController.swift
//  EventMaker
//
//  Created by Олег Романов on 22.04.2022.
//

import SPAlert
import UIKit

final class EventsContoller: UIViewController {
    // MARK: - Properties

    var customView = EventsView()

    var presenter: EventsViewOutput?

    // MARK: - Life cycle

    init() {
        super.init(nibName: nil, bundle: nil)
        view = customView
        setup()
        addActionHandlers()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        setup()
        addActionHandlers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadEvents()
        customView.dataSource?.detailedEventClosure = { [weak self] event in
            self?.presentDetailedEvent(event: event)
        }
        customView.dataSource?.deleteEventClosure = { [weak self] id in
            self?.deleteEvent(by: id)
        }
    }

    // MARK: - Init

    private func setup() {
        presenter = EventsPresenter(view: self)
        navigationItem.title = "События"
        navigationItem.rightBarButtonItem = customView.addPersonButton
        customView.initDataSource()
    }

    // MARK: - Action handlers

    private func addActionHandlers() {
        customView.addPersonButton.target = self
        customView.addPersonButton.action = #selector(addEventButtonClicked)
    }

    @objc private func addEventButtonClicked() {
    }

    // MARK: - In

    func showEvent(id: Int) {
        presenter?.getEvent(id: id)
    }
}

extension EventsContoller: EventsViewInput {
    func presentDetailedEvent(event: Event) {
        let detailedVC = DetailedEventController(event: event)
        detailedVC.title = event.name
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(detailedVC, animated: true)
    }

    func reloadEvents() {
        presenter?.getAllEvents()
    }

    func loadEvents(events: [Event]) {
        customView.updateData(events)
    }

    func deleteEvent(by id: Int) {
        if let presenter = presenter {
            presenter.deleteEvent(by: id) { [weak self] result in
                switch result {
                case let .success(event):
                    SPAlert.present(title: event, message: "Событие удалено", preset: .done)
                case let .failure(error):
                    self?.showError(message: error.localizedDescription)
                }
            }
        }
    }

    func showError(message: String) {
        SPAlert.present(title: "Событие не удалено", message: message, preset: .error)
    }
}
