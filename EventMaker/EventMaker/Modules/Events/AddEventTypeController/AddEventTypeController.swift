//
//  AddEventTypeController.swift
//  EventMaker
//
//  Created by Олег Романов on 28.04.2022.
//
import UIKit

class AddEventTypeController: UIViewController {
    lazy var customView: AddEventTypeView? = view as? AddEventTypeView

    var presenter: AddEventTypeOutput?

    init() {
        super.init(nibName: "AddEventTypeView", bundle: Bundle(for: AddEventTypeView.self))
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addActionHandlers()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = Text.AddEvent.add
        navigationItem.rightBarButtonItem = customView?.doneButton
    }

    private func addActionHandlers() {
        customView?.doneButton.action = #selector(doneButtonClicked)
    }

    @objc private func doneButtonClicked() {
        guard
            let name = customView?.addEventTypeNameField.text
//            name.isEmpty == false
        else { return }
        let newEventType = EventTypeDto(name: name)
        presenter?.createEventType(eventType: newEventType) { [weak self] result in
            switch result {
            case .success():
                self?.navigationController?.popViewController(animated: true)
            case let .failure(error):
                print("Ошибка: \(error)")
            }
        }
    }
}

extension AddEventTypeController: AddEventTypeInput {}

