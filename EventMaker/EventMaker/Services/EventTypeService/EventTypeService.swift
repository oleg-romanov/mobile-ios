//
//  EventTypeService.swift
//  EventMaker
//
//  Created by Олег Романов on 27.04.2022.
//

import Foundation
import Moya

enum CreateEventTypeResult {
    case success(eventType: EventType)
    case failure(error: Error)
}

enum GetAllEventTypesResult {
    case success(eventTypes: [EventType])
    case failure(error: Error)
}

protocol EventTypeServiceProtocol {
    func createEventType(eventType: EventTypeDto, completion: @escaping (CreateEventTypeResult) -> Void)
    func getAllEventTypes(completion: @escaping (GetAllEventTypesResult) -> Void)
}

class EventTypeService: EventTypeServiceProtocol {
    let dataProvider = MoyaProvider<EventTypeServiceApi>(plugins: [
        NetworkLoggerPlugin(),
    ])

    func createEventType(eventType: EventTypeDto, completion: @escaping (CreateEventTypeResult) -> Void) {
        print(eventType)
        dataProvider.request(.createEventType(eventType: eventType)) { result in
            switch result {
            case let .success(moyaResponse):
                guard (200 ... 299).contains(moyaResponse.statusCode)
                else {
                    let message = try? moyaResponse.map(String.self, atKeyPath: "message")
                    completion(.failure(error: CustomError(errorDescription: message)))
                    return
                }
                do {
                    let dataResponse = try moyaResponse.map(EventType.self)
                    print(dataResponse)
                    completion(.success(eventType: dataResponse))
                } catch {
                    completion(.failure(error: error))
                }
            case let .failure(error):
                completion(.failure(error: error))
            }
        }
    }

    func getAllEventTypes(completion: @escaping (GetAllEventTypesResult) -> Void) {
        dataProvider.request(.getAllEventTypes) { result in
            switch result {
            case let .success(moyaResponse):
                guard (200 ... 299).contains(moyaResponse.statusCode)
                else {
                    let message = try? moyaResponse.map(String.self, atKeyPath: "message")
                    completion(.failure(error: CustomError(errorDescription: message)))
                    return
                }
                do {
                    let dataResponse = try moyaResponse.map([EventType].self)
                    completion(.success(eventTypes: dataResponse))
                } catch {
                    completion(.failure(error: error))
                }
            case let .failure(error):
                completion(.failure(error: error))
            }
        }
    }
}
