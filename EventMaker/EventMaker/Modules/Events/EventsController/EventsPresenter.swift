//
//  EventsPresenter.swift
//  EventMaker
//
//  Created by Олег Романов on 21.04.2022.
//

import KeychainSwift
import UIKit

class EventsPresenter {
    private weak var view: EventsViewInput?

    private let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)

    private let service: EventServiceProtocol

    init(view: EventsViewInput, service: EventServiceProtocol = EventService()) {
        self.view = view
        self.service = service
    }
}

extension EventsPresenter: EventsViewOutput {
    func getAllEvents() {
        service.getAllEvents { [weak self] result in
            switch result {
            case let .success(events: events):
                self?.view?.loadEvents(events: events)
            case let .failure(error: error):
                print(error)
                // Сделать показ ошибки
            }
        }
    }

    func getEvent(id: Int) {
        service.getEvent(id: id) { [weak self] result in
            switch result {
            case let .success(event: event):
                self?.view?.presentDetailedEvent(event: event)
            case let .failure(error: error):
                print(error)
            }
        }
    }

    func deleteEvent(by id: Int, complition: @escaping (Result<String, Error>) -> Void) {}
}
