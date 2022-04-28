//
//  CategoryController.swift
//  EventMaker
//
//  Created by Олег Романов on 26.04.2022.
//

import UIKit

class CategoryController: UIViewController {
    var customView = CategoryView()

    var presenter: CategoryViewOutput?

    init() {
        super.init(nibName: nil, bundle: nil)
        view = customView
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        reloadCategories()
        customView.dataSource?.addCategoryClosure = { [weak self] in
            self?.presentAddCategory()
        }
    }

    private func setup() {
        navigationItem.title = Text.Categories.title
        customView.initDataSource()
    }
}

extension CategoryController: CategoryViewInput {
    func presentAddCategory() {
        let addCategoryController = AddCategoryController()
        let addCategoryPresenter = AddCategoryPresenter(view: addCategoryController)
        addCategoryController.presenter = addCategoryPresenter
        navigationController?.pushViewController(addCategoryController, animated: true)
    }

    func reloadCategories() {
        presenter?.getAllCategories()
    }

    func loadCategories(categories: [Category]) {
        customView.updateData(categories)
    }
}
