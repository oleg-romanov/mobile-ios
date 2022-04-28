//
//  EventTypeController.swift
//  EventMaker
//
//  Created by Олег Романов on 28.04.2022.
//

import UIKit

class EventTypeController: UIViewController {
    var customView = EventTypeView()

    var presenter: EventTypeViewOutput?

    init() {
        super.init(nibName: nil, bundle: nil)
        view = customView
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        reloadEventTypes()
        customView.dataSource?.addEventTypeClosure = { [weak self] in
            self?.presentAddEventType()
        }
    }

    private func setup() {
        navigationItem.title = Text.EventTypes.title
//        navigationItem.rightBarButtonItem = customView.addPersonButton
//        customView?.dataSource?.delegate = self
        customView.initDataSource()
    }
}

extension EventTypeController: EventTypeViewInput {
    func presentAddEventType() {
        let addEventTypeController = AddEventTypeController()
        let addEventTypePresenter = AddEventTypePresenter(view: addEventTypeController)
        addEventTypeController.presenter = addEventTypePresenter
        navigationController?.pushViewController(addEventTypeController, animated: true)
    }

    func reloadEventTypes() {
        presenter?.getAllEventTypes()
    }

    func loadEventTypes(eventTypes: [EventType]) {
        customView.updateData(eventTypes)
    }
}
