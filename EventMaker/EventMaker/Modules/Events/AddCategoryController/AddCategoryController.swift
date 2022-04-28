//
//  AddCategoryController.swift
//  EventMaker
//
//  Created by Олег Романов on 27.04.2022.
//

import SPAlert
import UIKit

class AddCategoryController: UIViewController {
    lazy var customView: AddCategoryView? = view as? AddCategoryView

    var presenter: AddCategoryOutput?

    init() {
        super.init(nibName: "AddCategoryView", bundle: Bundle(for: AddCategoryView.self))
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
            let name = customView?.addCategoryNameField.text
        else { return }
        let newCategory = CategoryDto(name: name)
        presenter?.createCategory(category: newCategory) { [weak self] result in
            switch result {
            case .success():
                self?.navigationController?.popViewController(animated: true)
            case let .failure(error):
                SPAlert.present(title: "Категория не добавлена", message: error.localizedDescription, preset: .error)
                print("Ошибка: \(error)")
            }
        }
    }
}

extension AddCategoryController: AddCategoryInput {}
