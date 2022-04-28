//
//  EventTypeProtocols.swift
//  EventMaker
//
//  Created by Олег Романов on 28.04.2022.
//

import Foundation

protocol EventTypeViewInput: AnyObject {
    func reloadEventTypes()
    func loadEventTypes(eventTypes: [EventType])
    func presentAddEventType()
}

protocol EventTypeViewOutput: AnyObject {
    func getAllEventTypes()
    func createEventType(eventType: EventType)
}
