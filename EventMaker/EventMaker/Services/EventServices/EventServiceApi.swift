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
    case getAllEvents
    case getEvent(id: Int)
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
        case .getAllEvents:
            return "/event"
        case let .getEvent(id):
            return "/event/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getAllEvents:
            return .get
        case .getEvent:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getAllEvents:
            return .requestPlain
        case .getEvent:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json", "Authorization": "Bearer \(keychain.get(Keys.token)!)"]
    }
}

