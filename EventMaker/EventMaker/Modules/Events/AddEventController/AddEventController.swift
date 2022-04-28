//
//  AddEventController.swift
//  EventMaker
//
//  Created by Олег Романов on 27.04.2022.
//

import SPAlert
import UIKit
import UserNotifications

class AddEventController: UIViewController {
    // MARK: - Properties

    lazy var customView: AddEventView? = view as? AddEventView

//    weak var delegate: AddEventControllerDelegate?

    var presenter: AddEventViewOutput?

    var encoder = JSONEncoder()

    private var categoryId = -1
    private var eventTypeId = -1

    // MARK: - Init

    init() {
        super.init(nibName: "AddEventView", bundle: Bundle(for: AddEventView.self))
        setupStyle()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupStyle() {
        presenter = AddEventPresener(view: self)
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Добавить событие"
        navigationItem.rightBarButtonItem = customView?.doneButton
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addActionHandlers()
    }

    // MARK: - Action handlers

    private func addActionHandlers() {
        customView?.doneButton.target = self
        customView?.doneButton.action = #selector(doneBottonClicked)
        customView?.doneButton.target = self
        customView?.categoryButton.addTarget(self, action: #selector(categoryButtonClicked), for: .touchUpInside)
        customView?.typeButton.addTarget(self, action: #selector(typeButtonClicked), for: .touchUpInside)
    }

    @objc private func doneBottonClicked() {
        guard
            let name = customView?.nameTextField.text,
            let date = customView?.datePicker.date,
            let descriptionTextView = customView?.descriptionTextView.text
        else {
            return
        }
        // Доделать обработку пустых полей
        switch String.empty {
        case name:
            print("name пустой")
            SPAlert.present(message: "Введите название события", haptic: .error)
            return
        default:
            print()
        }

        if categoryId == -1 {
            SPAlert.present(message: "Необходимо выбрать категорию", haptic: .error)
            return
        }

        let event = EventDto(name: name, description: descriptionTextView, date: date, categoryId: categoryId, eventTypeId: eventTypeId)
        customView?.spinner.isHidden = false
        customView?.spinner.startAnimating()
        presenter?.createEvent(event: event) { [weak self] result in
            switch result {
            case let .success(event):
                SPAlert.present(title: event.name, message: "Событие создано", preset: .done)
                self?.scheduleNotification(date: event.date, titleOfNotification: event.name)
                self?.navigationController?.popViewController(animated: true)
            case let .failure(error):
                self?.showError(error: error)
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }

    @objc func categoryButtonClicked() {
        let categoriesVC = CategoryController()
        let categoriesPresenter = CategoryPresenter(view: categoriesVC)
        categoriesVC.customView.dataSource?.closure = { [weak self] categoryId, name in
            self?.categoryId = categoryId
            self?.customView?.categoryButton.setTitle(name, for: .normal)
        }
        categoriesVC.presenter = categoriesPresenter
        navigationController?.pushViewController(categoriesVC, animated: true)
        navigationItem.backButtonTitle = ""
    }

    @objc func typeButtonClicked() {
        let eventTypesVC = EventTypeController()
        let eventTypesPresenter = EventTypePresenter(view: eventTypesVC)
        eventTypesVC.customView.dataSource?.closure = { [weak self] eventTypeId, name in
            self?.eventTypeId = eventTypeId
            self?.customView?.typeButton.setTitle(name, for: .normal)
        }
        eventTypesVC.presenter = eventTypesPresenter
        navigationController?.pushViewController(eventTypesVC, animated: true)
        navigationItem.backButtonTitle = ""
    }

    func scheduleNotification(date: Date, titleOfNotification: String) {
        removeNotifications(withIdentifiers: ["notification"])

        let content = UNMutableNotificationContent()
        content.title = titleOfNotification
        content.body = "Не забудьте!"
        content.sound = .default

        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        print("Комнонентыыыыыыыыыыы : \(components)")
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)

        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
    }

    func removeNotifications(withIdentifiers identifiers: [String]) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
    }
}

extension AddEventController: AddEventViewInput {
    func showError(error: Error) {
        let alert = SPAlertView(title: "Событие не создано", message: "Ошибка:  \(error.localizedDescription)", preset: .error)
        alert.duration = 3
        alert.present()
    }
}

extension AddEventController: CategoryDelegate {
    func sendCategoryId(categoryId: Int) {}
    func stopAnimating() {
        customView?.spinner.stopAnimating()
    }
}
