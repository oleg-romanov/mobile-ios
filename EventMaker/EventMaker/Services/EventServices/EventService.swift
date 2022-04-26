//
//  EventService.swift
//  EventMaker
//
//  Created by Олег Романов on 23.04.2022.
//

import Foundation
import Moya

enum GetAllEventsResult {
    case success(events: [Event])
    case failure(error: Error)
}

enum GetEventResult {
    case success(event: Event)
    case failure(error: Error)
}

protocol EventServiceProtocol {
    func getAllEvents(completion: @escaping (GetAllEventsResult) -> Void)
    func getEvent(id: Int, completion: @escaping (GetEventResult) -> Void)
}

class EventService: EventServiceProtocol {
    let dataProvider = MoyaProvider<EventServiceApi>(plugins: [
        NetworkLoggerPlugin(),
    ])

    let decoder = JSONDecoder()

    let dateFormatter = DateFormatter()

    func getAllEvents(completion: @escaping (GetAllEventsResult) -> Void) {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        dataProvider.request(.getAllEvents) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case let .success(moyaResponse):
                guard (200 ... 299).contains(moyaResponse.statusCode)
                else {
                    let message = try? moyaResponse.map(String.self, atKeyPath: "message")
                    completion(.failure(error: CustomError(errorDescription: message)))
                    return
                }
                do {
                    let dataResponse = try strongSelf.decoder.decode([Event].self, from: moyaResponse.data)
                    completion(.success(events: dataResponse))
                } catch {
                    completion(.failure(error: error))
                }
            case let .failure(error):
                completion(.failure(error: error))
            }
        }
    }

    func getEvent(id: Int, completion: @escaping (GetEventResult) -> Void) {
        dataProvider.request(.getEvent(id: id)) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case let .success(moyaResponse):
                guard (200 ... 299).contains(moyaResponse.statusCode)
                else {
                    let message = try? moyaResponse.map(String.self, atKeyPath: "message")
                    completion(.failure(error: CustomError(errorDescription: message)))
                    return
                }
                do {
                    let dataResponse = try strongSelf.decoder.decode(Event.self, from: moyaResponse.data)
                    completion(.success(event: dataResponse))
                } catch {
                    completion(.failure(error: error))
                }
            case let .failure(error):
                completion(.failure(error: error))
            }
        }
    }
}
