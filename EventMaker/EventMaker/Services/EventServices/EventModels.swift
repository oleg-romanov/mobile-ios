//
//  EventModels.swift
//  EventMaker
//
//  Created by Олег Романов on 23.04.2022.
//

import Foundation

struct CustomeError: LocalizedError {
    var errorDescription: String?
}

struct CreateEventRequest: Encodable {
    let name: String
    let description: String
    let date: Date
    let categoryId: Int
    let eventTypeId: Int
}

struct EventResponse: Decodable {
    let id: Int
    let name: String
    let description: String
    let date: Date
    let category: Category
    let eventType: EventType
    let user: [User]
}

struct GetAllEventsResponse: Decodable {
    let events: [Event]
}

struct GetOneEvent: Decodable {
    let event: Event
}

struct CreateEvent: Encodable {
    let id: Int
}
