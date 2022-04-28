//
//  EventTypePresenter.swift
//  EventMaker
//
//  Created by Олег Романов on 28.04.2022.
//

import Foundation

class EventTypePresenter {
    private weak var view: EventTypeViewInput?

    private let service: EventTypeServiceProtocol?

    init(view: EventTypeViewInput, service: EventTypeServiceProtocol = EventTypeService()) {
        self.view = view
        self.service = service
    }
}

extension EventTypePresenter: EventTypeViewOutput {
    func getAllEventTypes() {
        service?.getAllEventTypes(completion: { [weak self] result in
            switch result {
            case let .success(eventTypes: eventTypes):
                self?.view?.loadEventTypes(eventTypes: eventTypes)
                print(eventTypes)
            case let .failure(error: error):
                break
            }
        })
    }

    func createEventType(eventType: EventType) {
        print("")
    }
}
