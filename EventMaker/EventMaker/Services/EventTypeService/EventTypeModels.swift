//
//  EventTypeModels.swift
//  EventMaker
//
//  Created by Олег Романов on 27.04.2022.
//

import Foundation

struct CreateEventTypeRequest: Encodable {
    let name: String
}

struct EventTypeResponse: Decodable {
    let id: Int
    let name: String
}

struct GetAllEventTypesResponse: Decodable {
    let eventTypes: [EventType]
}

struct EventTypeDto: Encodable {
    let name: String
}
