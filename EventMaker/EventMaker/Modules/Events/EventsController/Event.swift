//
//  Event.swift
//  EventMaker
//
//  Created by Олег Романов on 22.04.2022.
//

import UIKit

struct EventDto: Encodable {
    var name: String
    var description: String
    var date: Date
    var categoryId: Int
    var eventTypeId: Int
}

struct Event: Decodable {
    var id: Int
    var name: String
    var description: String
    var date: Date
    var category: Category
    var eventType: EventType
    var user: User
    var participants: [User]
}

struct EventType: Codable {
    let id: Int
    let name: String
}

struct Category: Codable {
    let id: Int
    let name: String
}

struct User: Codable {
    var name: String
}

struct Body: Decodable {
    var body: String
}
