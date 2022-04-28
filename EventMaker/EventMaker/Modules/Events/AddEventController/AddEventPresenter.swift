//
//  AddEventPresenter.swift
//  EventMaker
//
//  Created by Олег Романов on 26.04.2022.
//

import KeychainSwift
import UIKit

final class AddEventPresener {
    private weak var view: AddEventViewInput?

    private let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)

    private let service: EventServiceProtocol

    init(view: AddEventViewInput, service: EventServiceProtocol = EventService()) {
        self.view = view
        self.service = service
    }
}

extension AddEventPresener: AddEventViewOutput {
    func createEvent(event: EventDto, complition: @escaping (Result<Event, Error>) -> Void) {
        service.createEvent(event: event) { [weak self] result in
            self?.view?.stopAnimating()
            switch result {
            case let .success(event):
                complition(.success(event))
            case let .failure(error):
                complition(.failure(error))
                self?.view?.showError(error: error)
            }
        }
    }
}
