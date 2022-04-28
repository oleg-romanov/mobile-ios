//
//  CategoryPresenter.swift
//  EventMaker
//
//  Created by Олег Романов on 26.04.2022.
//

import Foundation

class CategoryPresenter {
    private weak var view: CategoryViewInput?

    private let service: CategoryServiceProtocol?

    init(view: CategoryViewInput, service: CategoryServiceProtocol = CategoryService()) {
        self.view = view
        self.service = service
    }
}

extension CategoryPresenter: CategoryViewOutput {
    func getAllCategories() {
        service?.getAllCategories(completion: { [weak self] result in
            switch result {
            case let .success(categories: categories):
                self?.view?.loadCategories(categories: categories)
                print(categories)
            case let .failure(error: error):
                break
            }
        })
    }

    func createCategory(category: Category) {
        print("")
    }
}
