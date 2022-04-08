//
//  AuthService.swift
//  EventMaker
//
//  Created by Олег Романов on 07.04.2022.
//

import Foundation
import Moya

protocol AuthServiceProtocol {
    func signIn(email: String, password: String, completion: @escaping (Result<TokenResponse, Error>) -> Void)
}

class AuthService: AuthServiceProtocol {
    let dataProvider = MoyaProvider<AuthServiceApi>(plugins: [NetworkLoggerPlugin()])

    func signIn(
        email: String, password: String,
        completion: @escaping (Result<TokenResponse, Error>) -> Void
    ) {
        dataProvider.request(.signIn(email: email, password: password)) { result in
            switch result {
            case let .success(moyaResponse):
                guard (200 ... 299).contains(moyaResponse.statusCode)
                else {
                    let message = try? moyaResponse.map(String.self, atKeyPath: "message")
                    completion(.failure(CustomError(errorDescription: message)))
                    return
                }
                do {
                    let tokenResponse = try moyaResponse.map(TokenResponse.self)
                    completion(.success(tokenResponse))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
