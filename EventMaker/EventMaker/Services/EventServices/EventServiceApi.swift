//
//  EventServiceApi.swift
//  EventMaker
//
//  Created by Олег Романов on 23.04.2022.
//

import Foundation
import KeychainSwift
import Moya

enum EventServiceApi {
    case createEvent(event: EventDto)
    case getAllEvents
    case getEvent(id: Int)
    case deleteEvent(id: Int)
}

extension EventServiceApi: AccessTokenAuthorizable {
    public var authorizationType: AuthorizationType? { return .bearer }
}

extension EventServiceApi: TargetType {
    var keychain: KeychainSwift {
        return KeychainSwift(keyPrefix: Keys.keyPrefix)
    }

    var baseURL: URL {
        return URL(string: URLPath.path)!
    }

    var path: String {
        switch self {
        case .createEvent:
            return "/event"
        case .getAllEvents:
            return "/event"
        case let .getEvent(id):
            return "/event/\(id)"
        case let .deleteEvent(id):
            return "/event/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .createEvent:
            return .post
        case .getAllEvents:
            return .get
        case .getEvent:
            return .get
        case .deleteEvent:
            return .delete
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case let .createEvent(event):
            let encoder = JSONEncoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            encoder.dateEncodingStrategy = .formatted(dateFormatter)
            let requestBody = CreateEventRequest(name: event.name, description: event.description, date: event.date, categoryId: event.categoryId, eventTypeId: event.eventTypeId)
            return .requestCustomJSONEncodable(requestBody, encoder: encoder)
        case .getAllEvents:
            return .requestPlain
        case .getEvent:
            return .requestPlain
        case .deleteEvent:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json", "Authorization": "Bearer \(keychain.get(Keys.token)!)"]
    }
}

