//
//  AddCategoryPresenter.swift
//  EventMaker
//
//  Created by Олег Романов on 27.04.2022.
//

import Foundation

class AddCategoryPresenter {
    private weak var view: AddCategoryInput?

    private let service: CategoryServiceProtocol?

    init(view: AddCategoryInput, service: CategoryServiceProtocol = CategoryService()) {
        self.view = view
        self.service = service
    }
}

extension AddCategoryPresenter: AddCategoryOutput {
    func createCategory(category: CategoryDto, complition: @escaping (Result<Void, Error>) -> Void) {
        service?.createCategory(category: category) { [weak self] result in
            switch result {
            case let .success(category: category):
                complition(.success(()))
            case let .failure(error): // mistake here
                complition(.failure(error))
//                self?.view?.showError(error: error)
            }
        }
    }
}
