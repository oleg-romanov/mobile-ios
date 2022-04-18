//
//  AuthServiceApi.swift
//  EventMaker
//
//  Created by Олег Романов on 07.04.2022.
//

import KeychainSwift
import Moya

enum AuthServiceApi {
    case signIn(email: String, password: String)
    case signUp(username: String, email: String, password: String)
}

extension AuthServiceApi: TargetType {
    var baseURL: URL {
        return URL(string: URLPath.path)!
    }

    var path: String {
        switch self {
        case .signIn:
            return "/sign-in"
        case .signUp:
            return "/sign-up"
        }
    }

    var method: Moya.Method {
        return .post
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case let .signIn(email, password):
            let requestBody = SignInRequest(email: email, password: password)
            return .requestJSONEncodable(requestBody)
        case let .signUp(username, email, password):
            let requestBody = SignUpRequest(name: username, email: email, password: password)
            return .requestJSONEncodable(requestBody)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
