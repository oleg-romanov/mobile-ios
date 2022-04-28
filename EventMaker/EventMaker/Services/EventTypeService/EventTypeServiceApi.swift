//
//  EventTypeServiceApi.swift
//  EventMaker
//
//  Created by Олег Романов on 27.04.2022.
//

import Foundation
import KeychainSwift
import Moya

enum EventTypeServiceApi {
    case createEventType(eventType: EventTypeDto)
    case getAllEventTypes
}

extension EventTypeServiceApi: AccessTokenAuthorizable {
    public var authorizationType: AuthorizationType? { return .bearer }
}

extension EventTypeServiceApi: TargetType {
    var keychain: KeychainSwift {
        return KeychainSwift(keyPrefix: Keys.keyPrefix)
    }

    var baseURL: URL {
        return URL(string: URLPath.path)!
    }

    var path: String {
        switch self {
        case .createEventType:
            return "/type"
        case .getAllEventTypes:
            return "/type"
        }
    }

    var method: Moya.Method {
        switch self {
        case .createEventType:
            return .post
        case .getAllEventTypes:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case let .createEventType(eventType):
            let requestBody = CreateEventTypeRequest(name: eventType.name)
            return .requestJSONEncodable(requestBody)
        case .getAllEventTypes:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json", "Authorization": "Bearer \(keychain.get(Keys.token)!)"]
    }
}
