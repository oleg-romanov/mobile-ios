//
//  EventsProtocols.swift
//  EventMaker
//
//  Created by Олег Романов on 21.04.2022.
//

import Foundation

protocol EventsViewInput: AnyObject {
    func reloadEvents()
    func loadEvents(events: [Event])
    func presentDetailedEvent(event: Event)
    func deleteEvent(by id: Int)
    func showError(message: String)
}

protocol EventsViewOutput: AnyObject {
    func getAllEvents()
    func getEvent(id: Int)
    func deleteEvent(by id: Int, complition: @escaping (Result<String, Error>) -> Void)
}
