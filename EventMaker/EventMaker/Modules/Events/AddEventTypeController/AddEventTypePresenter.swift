//
//  AddEventTypePresenter.swift
//  EventMaker
//
//  Created by Олег Романов on 28.04.2022.
//

import Foundation

class AddEventTypePresenter {
    private weak var view: AddEventTypeInput?

    private let service: EventTypeServiceProtocol?

    init(view: AddEventTypeInput, service: EventTypeServiceProtocol = EventTypeService()) {
        self.view = view
        self.service = service
    }
}

extension AddEventTypePresenter: AddEventTypeOutput {
    func createEventType(eventType: EventTypeDto, complition: @escaping (Result<Void, Error>) -> Void) {
        service?.createEventType(eventType: eventType) { [weak self] result in
            switch result {
            case let .success(eventType: eventType):
                complition(.success(()))
            case let .failure(error): // mistake here
                complition(.failure(error))
//                self?.view?.showError(error: error)
            }
        }
    }
}
