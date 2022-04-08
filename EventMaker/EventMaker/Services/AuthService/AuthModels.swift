//
//  AuthModels.swift
//  EventMaker
//
//  Created by Олег Романов on 07.04.2022.
//

import Foundation

struct CustomError: LocalizedError {
    var errorDescription: String?
}

struct SignInRequest: Encodable {
    let email: String
    let password: String
}

struct TokenResponse: Decodable {
    let token: String
}
